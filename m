From: Ron Cococcia <ron.cococcia@request.com>
Subject: Re: intel8x0 dual codec issue
Date: Fri, 11 Feb 2005 11:30:49 -0500
Message-ID: <420CDDB9.6040805@request.com>
References: <4208437B.3080207@request.com>	<s5h8y5w1g2b.wl@alsa2.suse.de>	<420BB2FC.6070502@request.com> <s5hoeerz9dv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010007000106090006060400"
In-Reply-To: <s5hoeerz9dv.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010007000106090006060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Thu, 10 Feb 2005 14:16:12 -0500,
> Ron Cococcia wrote:
> 
>>I had been looking through that block of code, and had made some of my 
>>own "tweaks".  What I did was make "reg_ok" an array (size 4, all 
>>initialized to 0).  I used the codec index (cidx) to index into that 
>>array.  The idea is that there would be a reg_ok for each codec, instead 
>>of just 1 for all codecs.  This correctly set the output on all codecs 
>>after making the change.
> 
> 
> Yeah, that's better than my last hack.  Could you create a patch?

Attached.  I had a backup copy of the file that I diff'd against.  This 
is also based off of 1.0.8 files, but from what I could see the 
ac97_pcm.c file hasn't changed.  You'll also see a few snd_printk's in 
there that I had for testing/debugging purposes.  You can get rid of 
them if you want.

I'm not sure what the implications of changing the rates on all of the 
codecs are.  Is it possible that, in a multiple codec configuration, 
there would be a situation where they would want to be handling 
different rates?

<snip>

> Given that overriding codecs with NCR becomes popular, it might be
> nice to have a module option to specify the codecs as bitmask.
> The below is a quick hack.

I think I had tried something similar, but it oops'd the module.  When I 
did this, however, I knew beforehand that it was likely to not work. 
Your hack looks safer though.  I'll pop this in when I get some time and 
play with it and see how it works.

Thanks,
Ron

--------------010007000106090006060400
Content-Type: text/x-patch;
 name="ac97_pcm.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_pcm.c.patch"

--- ac97_pcm.c.orig	2005-02-08 15:42:46.000000000 -0500
+++ ac97_pcm.c	2005-02-11 11:03:49.757899504 -0500
@@ -312,6 +312,7 @@
 		return 0;
 	if (ac97_is_rev22(ac97) || ac97_can_amap(ac97)) {
 		unsigned short slots = 0;
+		/*snd_printk("ac97_is_rev22: %d\n", ac97_is_rev22(ac97));*/
 		if (ac97_is_rev22(ac97)) {
 			/* Note: it's simply emulation of AMAP behaviour */
 			u16 es;
@@ -553,10 +554,12 @@
 {
 	ac97_bus_t *bus;
 	int i, cidx, r, ok_flag;
-	unsigned int reg_ok = 0;
+	unsigned int reg_ok[4] = {0,0,0,0};
 	unsigned char reg;
 	int err = 0;
 
+	snd_printk("slots: 0x%04X\n", slots);
+
 	r = rate > 48000;
 	bus = pcm->bus;
 	if (cfg == AC97_PCM_CFG_SPDIF) {
@@ -597,19 +600,23 @@
 			continue;
 		for (cidx = 0; cidx < 4; cidx++) {
 			if (pcm->r[r].rslots[cidx] & (1 << i)) {
+				snd_printk("matching slot: cidx=%d, slot=%d\n", cidx, i);
 				reg = get_slot_reg(pcm, cidx, i, r);
 				if (reg == 0xff) {
 					snd_printk(KERN_ERR "invalid AC97 slot %i?\n", i);
 					continue;
 				}
-				if (reg_ok & (1 << (reg - AC97_PCM_FRONT_DAC_RATE)))
+				if (reg_ok[cidx] & (1 << (reg - AC97_PCM_FRONT_DAC_RATE)))
 					continue;
 				//printk(KERN_DEBUG "setting ac97 reg 0x%x to rate %d\n", reg, rate);
+				snd_printk("setting ac97 reg 0x%x to rate %d (codec %d)\n", reg, rate, cidx);
 				err = snd_ac97_set_rate(pcm->r[r].codec[cidx], reg, rate);
 				if (err < 0)
 					snd_printk(KERN_ERR "error in snd_ac97_set_rate: cidx=%d, reg=0x%x, rate=%d, err=%d\n", cidx, reg, rate, err);
-				else
-					reg_ok |= (1 << (reg - AC97_PCM_FRONT_DAC_RATE));
+				else {
+					reg_ok[cidx] |= (1 << (reg - AC97_PCM_FRONT_DAC_RATE));
+					snd_printk("success in snd_ac97_set_rate: cidx=%d, reg=0x%x, rate=%d\n", cidx, reg, rate);
+				}
 			}
 		}
 	}

--------------010007000106090006060400--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
