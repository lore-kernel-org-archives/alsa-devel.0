From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [PATCH V0.1] C-Media CMI9761 -A- type
Date: Thu, 17 Feb 2005 05:10:08 +0100
Message-ID: <42141920.4010504@gmx.de>
References: <4212D866.5000304@gmx.de> <s5hk6p8bx3v.wl@alsa2.suse.de>	 <4213F306.50802@gmx.de>  <4213F8F4.505@gmx.de> <1108611462.11521.28.camel@bastov>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080501030203010309020706"
In-Reply-To: <1108611462.11521.28.camel@bastov>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080501030203010309020706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

hi,

created a patch with branch -A- type support by Mainboard for the start.

like youve done it before for a mainboard in the code.


and now i want a pcm slider. lets see...



hello,

Sergio Monteiro Basto wrote:
| Hi,
|
| After search on https://bugtrack.alsa-project.org/ for CMI9761, 1
| issues, resolved !
| with some similarity is one ASRock k7vt4a+ with CMedia CMI9761, I have
| one ASRock P4VT8+ with CMedia CMI9761.

ive got the follower CMI9761A.

got ascreenshot from cmedia windosdriver app, for "unbeliefers" ;)

|
| After play around with alsamixer,
| I got sound when unmute PCM and Off (mute) IEC958 Capture Monitor.
|
| All others controls does change anything include mute or unmute the
| Master.
| Except VIA DXS (this one can do sound balance, left and right).
| VIA DXS 1, VIA DXS 2 and VIA DXS 3 also doesn't do nothing.
|
| Play around with
| options snd-via82xx dxs_support
| on file /etc/modprobe.conf
| only with "options snd-via82xx dxs_support=2" I see any difference but
| for worst, make disappear VIA DXS, VIA DXS 1, VIA DXS 2 and VIA DXS 3
| controls.
|
| So, can help you testing alsa CVS ?
| Now I have to sleep and tomorrow, I am a little busy but, have you some
| patch in specific to test this C-MEDIA sound card ?
|
| Sorry for my weak English, if you don't understand something just ask
| me, that I will try explain again.
|
| thanks,
|

all verified yet yesterday, negative

thx
tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iQCVAwUBQhQZHWqsze5HSzyoAQMpmgP9EB7DJoUUkYMrLbBniIiXZ+4zzPYxfpRN
Hv13zEvbxSs4LTzZtgD5Kbmtey55CV+mbaTArhGRKQ/O60RNrxk6pcri3ASxm6DM
uTdAWGjk8F1tXoFYF5WWD8tvyIDvGIw/Zh1UGdmeIvpvEjpwrM7i3Ca9UVeYjMk9
z8Laxy3nhIk=
=ug02
-----END PGP SIGNATURE-----

--------------080501030203010309020706
Content-Type: text/x-patch;
 name="alsa-driver-CM9761A-0.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-CM9761A-0.1.diff"

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

--------------080501030203010309020706--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
