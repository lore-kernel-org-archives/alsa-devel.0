From: Zinx Verituse <zinx@epicsol.org>
Subject: Re: CMI9739A
Date: Sun, 12 Dec 2004 03:30:13 -0600
Message-ID: <20041212093013.GA338@bliss>
References: <20041125004649.GA21551@bliss> <s5hact5oqa6.wl@alsa2.suse.de> <20041130020525.GA2591@bliss> <s5h1xebps0f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from imf18aec.mail.bellsouth.net (imf18aec.mail.bellsouth.net [205.152.59.66])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A2D3832E
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2004 10:30:08 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h1xebps0f.wl@alsa2.suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 30, 2004 at 11:09:52AM +0100, Takashi Iwai wrote:
> At Mon, 29 Nov 2004 20:05:25 -0600,
> Zinx Verituse wrote:
> > 
> > [1  <text/plain; us-ascii (7bit)>]
> > On Thu, Nov 25, 2004 at 05:18:57PM +0100, Takashi Iwai wrote:
> > > At Wed, 24 Nov 2004 18:46:49 -0600,
> > > Zinx Verituse wrote:
> > > > 
> > > > I recently purchased a motherboard with an on-board CMI9739A (or so it claims)
> > > > 
> > > > the id is: 0x434d4983
> > > > 
> > > > Unfortunately, simply adding the line:
> > > > 
> > > > { 0x434d4983, 0xffffffff, "CMI9739A",           patch_cm9739,   NULL },
> > > > 
> > > > causes the card to be muted, reguardless of the mixer, because of the init
> > > > code in patch_cm9739 -- the init code apparently isn't compatible.
> > > > 
> > > > Removing the initialization code, but leaving the ops, gives a few more
> > > > functional mixer options (like "Line-In as Surround" and "Mic as Center/LFE")
> > > 
> > > According to the datasheet, CM9739A is indeed compatible with 9739
> > > except for pins.
> > > 
> > > Could you get the ac97 register dump of the good- and bad-running
> > > states (from /proc/asound/card0/codec97#0/* files) ?
> > > 
> > > I guess the GPIO initialization (for using HP) is wrong there.  Doing
> > > the following helps?
> > > 
> > > 	# echo 72 0001 > /proc/asound/card0/codec97#0/ac97#0-0+regs
> > 
> > Sorry it took so long to get back to you -- I've attached the following files:
> > cmi9739a-working-ac97.txt       - output from working */codec97#0/ac97#0-0
> > cmi9739a-working-ac97-regs.txt  - output from working */codec97#0/ac97#0-0+regs
> > cmi9739a-muted-ac97.txt         - output from muted */codec97#0/ac97#0-0
> > cmi9739a-muted-ac97-regs.txt    - output from muted */codec97#0/ac97#0-0+regs
> > 
> > attempting to write to ac97#0-0+regs with the following:
> > 72 0001
> > 0:72 0001
> > 72=0001
> > 72 = 0001
> > 0:72 = 0001
> > met with the error:
> > -su: /proc/asound/card1/codec97#0/ac97#0-0+regs: No such device
> 
> Did you compile ALSA drivers with the debug option?

Sorry for the even longer delay this time -- I hadn't compiled debug in,
but have now.

Results:
72 0001 does nothing.

However, setting one of the registers that actually differs - 64 - does
fix it.  The other registers that changed (6c, 70) seemed to have no effect.

Non-working value for register 0x64: 0x5400
Working value for register 0x64: 0x1438

Also working value for register 0x64: 0x0010

Bit 4 doesn't appear to be documented in the source, or in the CM9739
documentation, and it actually defaults to 0x1438 here rather than 0x0000,
so I've made a patch that just keeps the value (luckily, it seems to default
to on when the card is initialized).

The patch also includes the id for the 9739A.
The patch is against 2.6.10-rc3, but it's fairly simple so it shouldn't
be too hard to apply by hand if it fails.

-- 
Zinx Verituse                                    http://zinx.xmms.org/

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-2.6.10-rc3-CM9739A.diff"

diff -ru linux-2.6.10-rc3.orig/sound/pci/ac97/ac97_codec.c linux-2.6.10-rc3/sound/pci/ac97/ac97_codec.c
--- linux-2.6.10-rc3.orig/sound/pci/ac97/ac97_codec.c	2004-12-12 03:11:18.000000000 -0600
+++ linux-2.6.10-rc3/sound/pci/ac97/ac97_codec.c	2004-12-12 03:21:40.000000000 -0600
@@ -118,6 +118,7 @@
 { 0x414c4770, 0xfffffff0, "ALC203",		NULL,		NULL },
 { 0x434d4941, 0xffffffff, "CMI9738",		patch_cm9738,	NULL },
 { 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },
+{ 0x434d4983, 0xffffffff, "CMI9739A",		patch_cm9739,	NULL },
 { 0x434d4978, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
 { 0x434d4982, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
 { 0x434d4983, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
diff -ru linux-2.6.10-rc3.orig/sound/pci/ac97/ac97_patch.c linux-2.6.10-rc3/sound/pci/ac97/ac97_patch.c
--- linux-2.6.10-rc3.orig/sound/pci/ac97/ac97_patch.c	2004-12-12 03:11:18.000000000 -0600
+++ linux-2.6.10-rc3/sound/pci/ac97/ac97_patch.c	2004-12-12 03:22:48.000000000 -0600
@@ -1766,8 +1766,10 @@
 	/* bit 12: disable center/lfe (swithable) */
 	/* bit 10: disable surround/line (switchable) */
 	/* bit 9: mix 2 surround off */
+	/* bit 4: undocumented; 0 mutes the CM9739A, which defaults to 1 */
 	/* bit 0: dB */
-	val = (1 << 13);
+	val = snd_ac97_read(ac97, AC97_CM9739_MULTI_CHAN) & (1 << 4);
+	val |= (1 << 13);
 	if (! (ac97->ext_id & AC97_EI_SPDIF))
 		val |= (1 << 14);
 	snd_ac97_write_cache(ac97, AC97_CM9739_MULTI_CHAN, val);

--KsGdsel6WgEHnImy--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
