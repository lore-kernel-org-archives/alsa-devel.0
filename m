From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [Alsa-user] Impossible to make subwoofer work
	on	a	Dell XPS M1710w
Date: Sun, 19 Aug 2007 09:06:23 -0700
Message-ID: <1187539583.4189.123.camel@razman.gruemaster.com>
References: <46C4E23A.5090000@gia.usb.ve>
	<200708171909.49451.mgerdau@tiscali.de> <s5h7inunjnw.wl%tiwai@suse.de>
	<200708191532.11011.mgerdau@tiscali.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GfC6ZK0n2CgoJzmS6UVO"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ADD62433A
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Aug 2007 18:06:26 +0200 (CEST)
In-Reply-To: <200708191532.11011.mgerdau@tiscali.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Gerdau <mgerdau@tiscali.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-GfC6ZK0n2CgoJzmS6UVO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was looking over some other Dell INF files, and found a newer pin def
listing for this system.  Try this patch and see if it fixes your
Center/LFE settings.

Tobin

On Sun, 2007-08-19 at 15:31 +0200, Michael Gerdau wrote:

> > Do you mean a problem with the missing LFE?  The missing LFE sounds
> > like a different problem.  AFAIK, the device itself _is_ set up
> > properly as expected.
> 
> I mean the missing LFE.
> 
> I can confirm the device otherwise works as adverticed. In fact I only
> (kind of) miss the LFE since I read in another post it should be there :-)
> 
> > And, if it's about debugging, let's discuss on alsa-devel ML and drop
> > Cc from alsa-users.
> 
> I've run the current alsa-info.sh as suggested by Tobis Davis (thanks
> for the pointer BTW) and had it upload the result automatically.
> 
> > Why not patch the code :)
> 
> That was my first idea :)
> 
> When I boldly started looking at it I realized I'm in for a steep learning
> curve. Not that I won't walk that road, but it will take me some time...
> 
> For a start I downloaded "Writing an alsa driver" and alsa-driver-api and
> will start reading it "real soon" (TM)
> 
> > As a hint, if it's really a regression, try to revert to the version
> > it did work.  Check /proc/asound/card0/codec#* file to see which
> > widget is changed by the LFE volume.  That's the vital information.
> 
> I don't know whether it actually is a regression or a not-yet-implemented
> feature. I do own my XPS M1710 since around March/April 2007 and I don't
> recall to have seen it. However sound worked right from the start and until
> recently I wasn't even aware there should be a LFE control. In fact the
> only "evidence" I have there should be one is already mentioned other post.
> 
> 
> That having said:
> The link http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh should
> probably go into ALSA-Configuration.txt
> 
> I also suggest to add a troubleshooting section into the navigation block
> of the entry page of alsa wiki (or move the existing one there -- I have
> not been able to easily find an existing one though) which mentions this
> link as well as all other stuff that a user should be aware of when
> reporting a problem.
> 
> If it isn't easy to provide concise troubleshooting instructions it would
> at least be helpful to give an overview where and how to find the relevant
> info in the wiki.
> 
> After all the user having a problem often is just starting learning alsa.
> 
> Best,
> Michael
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


	"I thought you were trying to get into shape."
	"I am. The shape I've selected is a triangle."

--=-GfC6ZK0n2CgoJzmS6UVO
Content-Disposition: attachment; filename=Dell-XPS.patch
Content-Type: text/x-patch; name=Dell-XPS.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r d6314f13dcc7 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Aug 17 09:17:36 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Sun Aug 19 09:03:29 2007 -0700
@@ -39,6 +39,7 @@
 
 enum {
 	STAC_REF,
+	STAC_XPS,
 	STAC_9200_MODELS
 };
 
@@ -456,12 +458,19 @@ static unsigned int ref9200_pin_configs[
 	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
 };
 
+static unsigned int xps9200_pin_configs[8] = {
+	0x40c003fc, 0x0144131f, 0x04a11020, 0x90170310,
+	0x40f000fa, 0x0421121f, 0x90170310, 0x408003fb,
+};
+
 static unsigned int *stac9200_brd_tbl[STAC_9200_MODELS] = {
 	[STAC_REF] = ref9200_pin_configs,
+	[STAC_XPS] = xps9200_pin_configs,
 };
 
 static const char *stac9200_models[STAC_9200_MODELS] = {
 	[STAC_REF] = "ref",
+	[STAC_XPS] = "xps",
 };
 
 static struct snd_pci_quirk stac9200_cfg_tbl[] = {
@@ -480,9 +489,9 @@ static struct snd_pci_quirk stac9200_cfg
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cd,
 		      "Dell Inspiron E1705/9400", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01ce,
-		      "Dell XPS M1710", STAC_REF),
+		      "Dell XPS M1710", STAC_XPS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cf,
-		      "Dell Precision M90", STAC_REF),
+		      "Dell Precision M90", STAC_XPS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d6,
 		      "unknown Dell", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d8,

--=-GfC6ZK0n2CgoJzmS6UVO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-GfC6ZK0n2CgoJzmS6UVO--
