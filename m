From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: AC97 reset fail after suspend
Date: Thu, 14 May 2009 03:57:35 +0200
Message-ID: <200905140357.35682.marek.vasut@gmail.com>
References: <200905080148.20137.sleep_walker@suse.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Pq3CKwCxsPNWG3r"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id C5E242434F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:57:33 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id g7so372225muf.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:57:33 -0700 (PDT)
In-Reply-To: <200905080148.20137.sleep_walker@suse.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomas 'Sleep_Walker' Cech <sleep_walker@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_Pq3CKwCxsPNWG3r
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 of May 2009 01:48:19 Tomas 'Sleep_Walker' Cech wrote:
> Hi,
>
> I've got following error on Palm LifeDrive and PalmTX after suspend &
> resume:
>
> pxa2xx_ac97_try_warm_reset: warm reset timeout (GSR=0x0)
> pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x0)
> pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
> pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x44)
> WM9712 AC97 reset failed
> could not reset AC97 codec
>
> That completely disable whole AC97 communication, so touchscreen, sound and
> battery doesn't work any longer.
>
> I also tried this with Treo680 (code will be sent soon). HW is very
> similar, only codec is different - LD/T5/TX use WM9712, Treo680 use WM9713.
> On Treo680 there is no problem with that.
>
> Thanks for any hint about that.
>
> Tomas 'Sleep_Walker' Cech
>
> Attaching config for LD/TX and dmesg output.

The following patch fixes the issue and should be correct. It's indeed a 
regression that's not in wm9713, but is in wm9712. Please consider applying.

--Boundary-00=_Pq3CKwCxsPNWG3r
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-WM9712-coldreset-on-resume-bugfix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-WM9712-coldreset-on-resume-bugfix.patch"

=46rom 06dce145990fb342d66c8fc77704a3dff3c66313 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 14 May 2009 03:48:27 +0200
Subject: [PATCH] WM9712 coldreset on resume bugfix

The following patch fixes problem with wm9712 codec being unable to resume =
from
sleep because it doesn't respond after AC97 port was coldreseted (which is =
done
in case the warmreset wasn't successful). The solution uses similar approac=
h as
wm9713, that is, do one more warmreset after coldreset.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 sound/soc/codecs/wm9712.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 765cf1e..166ebac 100644
=2D-- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -585,6 +585,8 @@ static int wm9712_reset(struct snd_soc_codec *codec, in=
t try_warm)
 	}
=20
 	soc_ac97_ops.reset(codec->ac97);
+	if (soc_ac97_ops.warm_reset)
+		soc_ac97_ops.warm_reset(codec->ac97);
 	if (ac97_read(codec, 0) !=3D wm9712_reg[0])
 		goto err;
 	return 0;
=2D-=20
1.6.2.1


--Boundary-00=_Pq3CKwCxsPNWG3r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_Pq3CKwCxsPNWG3r--
