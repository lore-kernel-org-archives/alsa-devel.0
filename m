From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 6/9] rate: handle negative values from
	snd_pcm_mmap_playback_hw_avail
Date: Tue, 16 Sep 2014 21:52:51 +0600
Message-ID: <54185CD3.3030701@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>	<1410633021-20395-7-git-send-email-patrakov@gmail.com>	<s5hoauhw9oc.wl-tiwai@suse.de>	<5416B98D.3010505@gmail.com>
 <s5hbnqhw5pu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000708060203050108060706"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 59283261A18
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 17:52:54 +0200 (CEST)
Received: by mail-lb0-f172.google.com with SMTP id w7so56730lbi.31
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 08:52:53 -0700 (PDT)
In-Reply-To: <s5hbnqhw5pu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000708060203050108060706
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

15.09.2014 16:14, Takashi Iwai wrote:
> At Mon, 15 Sep 2014 16:03:57 +0600,
> Alexander E. Patrakov wrote:
>>
>> 15.09.2014 14:49, Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> At Sun, 14 Sep 2014 00:30:18 +0600,
>>> Alexander E. Patrakov wrote:
>>>>
>>>> Such negative returns are possible during an underrun if xrun detect=
ion
>>>> is disabled.
>>>>
>>>> So, don't store the result in an unsigned variable (where it will
>>>> overflow), and postpone the trigger in such case, too.
>>>>
>>>> Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
>>>> ---
>>>>
>>>> The patch is only compile-tested and the second hunk may well be wro=
ng.
>>>>
>>>> There are also similar issues in pcm_share.c, but, as I don't comple=
tely
>>>> understand the code there and cannot test that plugin at all due to
>>>> unrelated crashes, there will be no patch from me.
>>>
>>> In general, hw_avail must not be negative before starting the stream.
>>> If it is, then it means most likely the driver problem, so we should
>>> return error immediately instead.
>>
>> Thanks for the review. Would -EBADFD be a correct error code, or do yo=
u
>> want something different? or maybe even an assert?
>
> I'd take either EPIPE or EBADFD.
> An assert would be an overkill, IMO.

I have sent the fix to the list, but nobody reacted. Resending as an=20
attachment to this message.

--=20
Alexander E. Patrakov

--------------000708060203050108060706
Content-Type: text/x-patch;
 name="0001-pcm-rate-hw_avail-must-not-be-negative-before-starti.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-pcm-rate-hw_avail-must-not-be-negative-before-starti.pa";
 filename*1="tch"

>From 81d3b1b107e0f55f041eb9df8f6c3edd3e6450f4 Mon Sep 17 00:00:00 2001
From: "Alexander E. Patrakov" <patrakov@gmail.com>
Date: Mon, 15 Sep 2014 20:17:47 +0600
Subject: [PATCH] pcm, rate: hw_avail must not be negative before starting the
 stream

If it is, then it means most likely the driver problem, so we should
return error immediately instead.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---

As suggested by Takashi Iwai.

 src/pcm/pcm_rate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 736d558..c76db25 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1069,7 +1069,10 @@ static int snd_pcm_rate_start(snd_pcm_t *pcm)
 	gettimestamp(&rate->trigger_tstamp, pcm->tstamp_type);
 
 	avail = snd_pcm_mmap_playback_hw_avail(rate->gen.slave);
-	if (avail <= 0) {
+	if (avail < 0) /* can't happen on healthy drivers */
+		return -EBADFD;
+
+	if (avail == 0) {
 		/* postpone the trigger since we have no data committed yet */
 		rate->start_pending = 1;
 		return 0;
-- 
2.1.0


--------------000708060203050108060706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000708060203050108060706--
