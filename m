From: Amir Shamsuddin <AmirS2+alsa@gmail.com>
Subject: Re: Fwd: Possible bug in sound/pci/atiixp.c ?
Date: Mon, 14 Mar 2011 09:35:08 +0000
Message-ID: <AANLkTi=HN6sV7Prr6V3EsJ2AGdEvjbRsHf-D=gqN5OFb@mail.gmail.com>
References: <AANLkTi=fUJtmTRocCtV=CL=BTdMy2axMh1LvwiPUJ_L2@mail.gmail.com>
	<AANLkTikzgxstbYxnU4Jxb_EdKNqXE2L3CtSHyBGCwThM@mail.gmail.com>
	<s5hwrk5iunq.wl%tiwai@suse.de>
	<AANLkTin8DCML6m-LPFX0S5X_XzJhTsbD-1Oz2FhXDS5o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FDDC1037EA
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:35:09 +0100 (CET)
Received: by bwz10 with SMTP id 10so4141025bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 02:35:09 -0700 (PDT)
In-Reply-To: <AANLkTin8DCML6m-LPFX0S5X_XzJhTsbD-1Oz2FhXDS5o@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2011 at 2:50 PM, Amir Shamsuddin <AmirS2+alsa@gmail.com> wr=
ote:
> On Fri, Mar 11, 2011 at 2:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Fri, 11 Mar 2011 11:04:27 +0000,
>> Amir Shamsuddin wrote:
>>>
>>> Hi,
>>>
>>> My laptop occasionally fails to resume from suspend, and when it does,
>>> I see (only) this error message on screen:
>>>
>>> [nnn.nnn] atiixp: codec reset timeout
>>>
>>> I had a look at the code where this comes from, and while I'm not sure
>>> it's related to my resume problem, it does (to my untrained eyes) look
>>> like there is a small bug in the function snd_atiixp_aclink_reset in
>>> file sound/pci/atiixp.c:
>>>
>>> (lines 500 - 536 in latest git)
>>> static int snd_atiixp_aclink_reset(struct atiixp *chip)
>>> {
>>> =A0 =A0 =A0 =A0int timeout;
>>> [snip]
>>> =A0 =A0 =A0 =A0timeout =3D 10;
>>> =A0 =A0 =A0 =A0while (! (atiixp_read(chip, CMD) & ATI_REG_CMD_ACLINK_AC=
TIVE)) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* do a hard reset */
>>> [snip]
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (--timeout) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printk(KERN_ERR "ati=
ixp: codec reset timeout\n");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0}
>>> [snip]
>>> }
>>>
>>> Surely the timeout condition should be negated, so the timeout message
>>> and loop break is only hit when 'timeout' reaches zero? ie.
>>>
>>> if (! --timeout) {
>>>
>>> Or am I missing something?
>>
>> Indeed it's a bug. =A0Does the message go away when you change it?
>
> I haven't tried a new kernel with it fixed yet (I'm not usually a
> kernel developer), but I'll give it a go and try and trigger the
> resume bug and let you know what happens.

I've tried it now, the message does go away with the fix in.

Unfortunately it doesn't help my laptop resume, but I think that's a
separate problem!

Amir
