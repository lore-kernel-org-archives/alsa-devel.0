From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: softvol plugin [Fwd: Re: [Alsa-devel] [PATCH V0.1] C-Media
 CMI9761 -A- type]
Date: Sat, 19 Feb 2005 03:04:38 +0000
Message-ID: <1108782279.23185.38.camel@bastov>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-JmAxB7LzZGapt4FPzd6G"
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: t.schorpp@gmx.de, alsa-user@lists.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>, Jakob Schurdak <jakobs@myrealbox.com>
List-Id: alsa-devel@alsa-project.org


--=-JmAxB7LzZGapt4FPzd6G
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sorry for cross posting, I am replying to 2 different threads 1 is alsa-
user and other in alsa-devel!

Please cc to me!

Like Jakob Schurdak, I reinstall alsa from CVS (alsa-driver, alsa-lib,
alsa-utils),  that already have Takashi patch,  but the mixer still have
exactly the same behavior.=20

I have one ASRock P4VT8+ with CMedia CMI9761 (not the same of Jakob) but
same rev. of sound card.
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235=
/8237 AC97 Audio Controller (rev 60)

Applying this patch from Thomas Schorpp, I have a better mixer and don't
have mute nothing as before, I just unmute PCM and have sound, Master
volume appears but don't have any effect when mute or unmute or change
volume.

For me, try to set up a PCM config manually on my own ~/.asoundrc ,
doesn't change noting ( unless when I forget close  "}") :)

thanks and regards,

-------- Forwarded Message --------
> From: thomas schorpp <t.schorpp@gmx.de>
> Reply-To: t.schorpp@gmx.de
> To: alsa-devel <alsa-devel@lists.sourceforge.net>
> Subject: Re: [Alsa-devel] [PATCH V0.1] C-Media CMI9761 -A- type
> Date: Thu, 17 Feb 2005 05:10:08 +0100
> created a patch with branch -A- type support by Mainboard for the start=
.
>=20
> like youve done it before for a mainboard in the code.
>=20
>=20
> and now i want a pcm slider. lets see...
>=20
>=20
>=20
> hello,
>=20
> Sergio Monteiro Basto wrote:
> | Hi,
> |
> | After search on https://bugtrack.alsa-project.org/ for CMI9761, 1
> | issues, resolved !
> | with some similarity is one ASRock k7vt4a+ with CMedia CMI9761, I hav=
e
> | one ASRock P4VT8+ with CMedia CMI9761.
>=20
> ive got the follower CMI9761A.
>=20
> got ascreenshot from cmedia windosdriver app, for "unbeliefers" ;)
>=20
> |
> | After play around with alsamixer,
> | I got sound when unmute PCM and Off (mute) IEC958 Capture Monitor.
> |
> | All others controls does change anything include mute or unmute the
> | Master.
> | Except VIA DXS (this one can do sound balance, left and right).
> | VIA DXS 1, VIA DXS 2 and VIA DXS 3 also doesn't do nothing.
> |
> | Play around with
> | options snd-via82xx dxs_support
> | on file /etc/modprobe.conf
> | only with "options snd-via82xx dxs_support=3D2" I see any difference =
but
> | for worst, make disappear VIA DXS, VIA DXS 1, VIA DXS 2 and VIA DXS 3
> | controls.
> |
> | So, can help you testing alsa CVS ?
> | Now I have to sleep and tomorrow, I am a little busy but, have you so=
me
> | patch in specific to test this C-MEDIA sound card ?
> |
> | Sorry for my weak English, if you don't understand something just ask
> | me, that I will try explain again.
> |
> | thanks,
> |
>=20
> all verified yet yesterday, negative
>=20
> thx
> tom

--=20
S=E9rgio M.B.

--=-JmAxB7LzZGapt4FPzd6G
Content-Disposition: attachment; filename=alsa-driver-CM9761A-0.1.diff
Content-Type: text/x-patch; name=alsa-driver-CM9761A-0.1.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.74
diff -U3 -r1.74 ac97_patch.c
--- ac97_patch.c	16 Feb 2005 18:27:17 -0000	1.74
+++ ac97_patch.c	17 Feb 2005 03:24:52 -0000
@@ -2035,7 +2035,11 @@
 int patch_cm9761(ac97_t *ac97)
 {
 	unsigned short val;
-
+	
+	/* CM9761A only on this Mainboard Series for now, due to diverting infos(?) */
+	if( !ac97->pci && ac97->subsystem_vendor != 0x1849 && ac97->subsystem_device != 0x9761)
+	{
+	
 	/* CM9761 has no Master and PCM volume although the register reacts */
 	ac97->flags |= AC97_HAS_NO_MASTER_VOL | AC97_HAS_NO_PCM_VOL;
 	snd_ac97_write_cache(ac97, AC97_MASTER, 0x8000);
@@ -2085,6 +2089,31 @@
 	else
 		val = 0x321c;
 #endif
+
+	/* FIXME: set up GPIO */
+	snd_ac97_write_cache(ac97, 0x70, 0x0100);
+	snd_ac97_write_cache(ac97, 0x72, 0x0020);
+
+	}
+	else
+	{
+	
+	/* CM9761A */
+
+	unsigned short val;
+
+	ac97->build_ops = &patch_cm9761_ops;
+	
+#if 0
+	/* enable spdif */
+	/* force the SPDIF bit in ext_id - codec doesn't set this bit! */
+        ac97->ext_id |= AC97_EI_SPDIF;
+	/* to be sure: we overwrite the ext status bits */
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_STATUS, 0x05c0);
+	snd_ac97_write_cache(ac97, AC97_CM9761_SPDIF_CTRL, 0x0209);
+	ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_48000; /* 48k only */
+#endif
+	/* set-up multi channel */
 	val = snd_ac97_read(ac97, AC97_CM9761_MULTI_CHAN);
 	val |= (1 << 4);
 	snd_ac97_write_cache(ac97, AC97_CM9761_MULTI_CHAN, val);
@@ -2092,10 +2121,12 @@
 	/* FIXME: set up GPIO */
 	snd_ac97_write_cache(ac97, 0x70, 0x0100);
 	snd_ac97_write_cache(ac97, 0x72, 0x0020);
-
+	}
+	
 	return 0;
 }
        
+       
 
 /*
  * VIA VT1616 codec

--=-JmAxB7LzZGapt4FPzd6G--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
