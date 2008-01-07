From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA:  Enable chipset gcap usage
Date: Mon, 07 Jan 2008 10:00:20 -0800
Message-ID: <1199728820.4061.149.camel@razman.gruemaster.com>
References: <1199403245.3732.450.camel@razman.gruemaster.com>
	<s5hir25aola.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1smdfGaNaTlSnS3vpLkB"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E4C4924970
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 19:00:23 +0100 (CET)
In-Reply-To: <s5hir25aola.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-1smdfGaNaTlSnS3vpLkB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2008-01-07 at 11:59 +0100, Takashi Iwai wrote:

> At Thu, 03 Jan 2008 15:34:05 -0800,
> Tobin Davis wrote:
> > 
> > Summary:  hda_intel.c use gcap register to determine number of streams
> > supported by southbridge.
> > 
> > This patch removes hardcoded values for the number of streams supported
> > by the southbridge in most chipsets, and reads these values from the
> > chipset directly.  Most systems are hardwired for 4 streams in each
> > direction, but newer chipsets change that capability.
> > 
> > 
> > Signed off by Tobin Davis <tdavis@dsl-only.net>
> > [2 hda-gcap.patch <text/x-patch; UTF-8 (7bit)>]
> > diff -r 1227a1c12325 pci/hda/hda_intel.c
> > --- a/pci/hda/hda_intel.c	Mon Dec 24 14:40:56 2007 +0100
> > +++ b/pci/hda/hda_intel.c	Thu Jan 03 15:27:10 2008 -0800
> > @@ -1709,12 +1709,13 @@ static int __devinit azx_create(struct s
> >  {
> >  	struct azx *chip;
> >  	int err;
> > +	unsigned short gcap;
> >  	static struct snd_device_ops ops = {
> >  		.dev_free = azx_dev_free,
> >  	};
> >  
> >  	*rchip = NULL;
> > -	
> > +
> >  	err = pci_enable_device(pci);
> >  	if (err < 0)
> >  		return err;
> > @@ -1790,10 +1791,19 @@ static int __devinit azx_create(struct s
> >  		chip->capture_index_offset = ATIHDMI_CAPTURE_INDEX;
> >  		break;
> >  	default:
> > -		chip->playback_streams = ICH6_NUM_PLAYBACK;
> > -		chip->capture_streams = ICH6_NUM_CAPTURE;
> > -		chip->playback_index_offset = ICH6_PLAYBACK_INDEX;
> > -		chip->capture_index_offset = ICH6_CAPTURE_INDEX;
> > +		/* read number of streams from GCAP register instead of using
> > +		 * hardcoded value
> > +		 */
> > +		gcap = azx_readw(chip, GCAP);
> > +		if(!gcap) {
> > +			snd_printk(KERN_ERR "Device has no streams \n");
> > +			goto errout;
> > +		};
> 
> I think it's safer to assign old ICH6_* values in this case (just to
> be sure) after a warning message.


Actually, this should never have been hardcoded in the first place.  The
HDA PRM (April 2005) states that the value returned is hardwired to 4
streams in the ICH6/7 southbridge of the Intel chipset.  By hardcoding
the values in the driver, we don't allow changes to future (hint - real
soon) chipsets.  This just cleans up this bit of code that has been
around since this code was created.  If I had the other systems in the
case statement to test, I'm sure we could do away with the case
statement entirely, just by reading the values instead of second
guessing them.  If the chipsets follow the spec, this method should work
all around.


> > +		chip->playback_streams = (gcap&(0xF<<12))>>12;
> > +		chip->capture_streams = (gcap&(0xF<<8))>>8;
> > +		chip->playback_index_offset = (gcap&(0xF<<12))>>12;
> > +		chip->capture_index_offset = 0;

I'm not entirely convinced of this method for the index_offsets, but it
works on tested systems here.  I'll review the PRM for more guidance.


> > +
> >  		break;
> >  	}
> >  	chip->num_streams = chip->playback_streams + chip->capture_streams;
> 
> The patch has some coding style issues, for example, no space around
> operators, etc.  Try to run $LINUX/scripts/checkpatch.pl, fix the
> errors and the issue above, and please repost the patch again.

This must be a new script in the kernel.  My development system (2.6.17)
doesn't have it, but it is on my laptop (2.6.22).  I ran it, ant it
reported one error " if(!gcap) " which I fixed.  I also added some
spacing around the bit manipulation code for streams and offsets.  

This code actually was part of a larger patch to enable audio on a new
chipset due out later this year.  I only took the code that can be
mainstreamed (the rest were prerelease specific fixes that are not
relevant to production silicon - and none of it would have passed coding
style tests).  I'll have another patch in a few months with the new
device info, once it clears legal.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-1smdfGaNaTlSnS3vpLkB
Content-Disposition: attachment; filename=hda-gcap.patch
Content-Type: text/x-patch; name=hda-gcap.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 1227a1c12325 pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Mon Dec 24 14:40:56 2007 +0100
+++ b/pci/hda/hda_intel.c	Thu Jan 03 15:27:10 2008 -0800
@@ -1709,12 +1709,13 @@ static int __devinit azx_create(struct s
 {
 	struct azx *chip;
 	int err;
+	unsigned short gcap;
 	static struct snd_device_ops ops = {
 		.dev_free = azx_dev_free,
 	};
 
 	*rchip = NULL;
-	
+
 	err = pci_enable_device(pci);
 	if (err < 0)
 		return err;
@@ -1790,10 +1791,19 @@ static int __devinit azx_create(struct s
 		chip->capture_index_offset = ATIHDMI_CAPTURE_INDEX;
 		break;
 	default:
-		chip->playback_streams = ICH6_NUM_PLAYBACK;
-		chip->capture_streams = ICH6_NUM_CAPTURE;
-		chip->playback_index_offset = ICH6_PLAYBACK_INDEX;
-		chip->capture_index_offset = ICH6_CAPTURE_INDEX;
+		/* read number of streams from GCAP register instead of using
+		 * hardcoded value
+		 */
+		gcap = azx_readw(chip, GCAP);
+		if (!gcap) {
+			snd_printk(KERN_ERR "Device has no streams \n");
+			goto errout;
+		};
+		chip->playback_streams = (gcap & (0xF << 12)) >> 12;
+		chip->capture_streams  = (gcap & (0xF << 8)) >> 8;
+		chip->playback_index_offset = (gcap & (0xF << 12)) >> 12;
+		chip->capture_index_offset = 0;
+
 		break;
 	}
 	chip->num_streams = chip->playback_streams + chip->capture_streams;

--=-1smdfGaNaTlSnS3vpLkB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-1smdfGaNaTlSnS3vpLkB--
