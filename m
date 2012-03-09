From: Mark Hills <mark@pogo.org.uk>
Subject: Re: usb-audio: Correct way to do a mixer quirk?
Date: Fri, 9 Mar 2012 12:13:58 +0000 (GMT)
Message-ID: <alpine.LNX.2.01.1203091134140.4693@stax.localdomain>
References: <alpine.LNX.2.01.1202192059040.7408@stax.localdomain>
	<4F41FF5F.8040409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id B805110B9A8
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:13:59 +0100 (CET)
In-Reply-To: <4F41FF5F.8040409@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Feb 2012, Clemens Ladisch wrote:

> Mark Hills wrote:
> > The Electrix Ebox-44 is a new USB interface, but the MIXER_UNIT descriptor
> > is broken and refers to a non-existing unit_id.
> >
> > I worked around it with the patch below to remove the additional entry,
> > and the device seems to work as expected.
> >
> > But inserting code here is probably not desirable -- I imagine I need to
> > turn this into a quirk of some sort. Am I correct?
> >
> > And what is the best way to do this?
> >
> > * It doesn't appear I can use quirks-table.h to adjust the content
> >   of a mixer unit (the bNrInPins attribute)
> >
> > * It seems that to use mixer_quirks.c would require a function to
> >   create the whole mixer
> >
> > It's possible I'm incorrect on the above, though. Can anyone advise on how
> > to make this fix in the correct way?
> 
> I'd suggest to change the code to not abort if a unit doesn't exist.

After changing this code I find myself up against other bad things about 
the desciptor.

The input mixer is not visible. It has a FEATURE_UNIT (10) but referred to 
by a broken MIXER_UNIT (11). There is Maya44 code which stops it being 
found (see below). Removing it and the control is visible. But that does 
not excuse the bad MIXER_UNIT.

Even with the hack, alsamixer presents the 2 volumes as (left, right) 
pairs, when they are actually 2 volumes controlling input pair 1, and 
input pair 2. It would be sensible to present this as 2x mono controls.

I mapped out the description coming from the device. I'm new here, but it 
seems odd that 4[FU] comes under 7[FU], and that outputs seem to be 
inputs. Is this description just badly broken, and is this a problem?

  7[FU] --> 6[MU] --> 5[IT] ("USB streaming")
                  --> 4[FU] --> 3[IT] ("Headphones")
                  --> 2[?]

  11[MU] --> 10[FU] --> 9[IT] ("Line connector")

  8[OT] ("Speaker")

  12[OT] ("USB Streaming")

Where am I best to go next?

eg. should I be trying to write code in mixer_quirks.c to build the 
desired mixer from scratch. And is this even possible to turn the 
left/right controls into mono?

Or is there some better way?

Thanks

-- 
Mark


diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c374c72..42df7b5 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1377,11 +1379,6 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid, void *r
                snd_printk(KERN_ERR "invalid MIXER UNIT descriptor %d\n", unitid);
                return -EINVAL;
        }
-       /* no bmControls field (e.g. Maya44) -> ignore */
-       if (desc->bLength <= 10 + input_pins) {
-               snd_printdd(KERN_INFO "MU %d has no bmControls field\n", unitid);
-               return 0;
-       }
 
        num_ins = 0;
        ich = 0;
