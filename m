From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000453]: it is impossible to select spdif as capture source
Date: Tue, 12 Oct 2004 14:54:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012125448.00C4718009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5B9452D9
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 14:54:48 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000453
======================================================================
Reported By:                Andrew
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     453
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             08-18-2004 13:16 CEST
Last Modified:              10-12-2004 14:54 CEST
======================================================================
Summary:                    it is impossible to select spdif as capture source
Description: 
There are no anything spdif-input-related among
capture source enumeration.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-25-2004 19:55 CEST 
----------------------------------------------------------------------
Did you use 'iec958' pcm?

    % arecord -Diec958 -fdat foo.wav

----------------------------------------------------------------------
 Andrew - 08-25-2004 23:47 CEST 
----------------------------------------------------------------------
A dat fromat doesn't work: "Sample format non available"
I have tried

arecord -Diec958 -fs32_LE -r48000 -c2 -d600 foo.wav

Format/rate are accepted, but the resulted file is empty.
I use aureon 7.1.

While filing the isuue, I have thought about capture selecting via
mixer Capture Source control. Does this (others?) control influence
to shown above command working?

----------------------------------------------------------------------
 tiwai - 08-27-2004 19:39 CEST 
----------------------------------------------------------------------
You can use'plug:iec958' for 16bit conversion.

"Capture Source" shouldn't affect the digital input.
It might be a wrong CS8415 initialization sequence in the driver...

----------------------------------------------------------------------
 Andrew - 09-07-2004 10:33 CEST 
----------------------------------------------------------------------
I have tried with plug:iec958 with the same silent file. Is there any way
to be sure spdif input is receiving some signal?

----------------------------------------------------------------------
 tiwai - 09-08-2004 17:16 CEST 
----------------------------------------------------------------------
Could you elaborate more?
Is the DMA working?  Or did you get the short-cut output?
Is it all zero or any signals in the output?

Also, as I wrote, the CS8415 init sequence might be wrong.
Compare the CS8415 init data in aureon.c with the datasheet
whether it's correct for your setting.

----------------------------------------------------------------------
 Andrew - 09-08-2004 17:55 CEST 
----------------------------------------------------------------------
Takashi,

You think I'm more clever than I am :-)

OK, the aim is simple: to be able to record from FM tuner. Last one is an
"onboard" tuner of AV receiver. Last one is the only source I can try as
source
with spdif output. All this is the reason of my last question about a way
to be
sure spdif input is receiving some signal: my sound card is the only
device I
can use to receive something via spdif.

All my attempts of capturing from spdif input lead to silent wav file.

I will be happy to answer to your question about DMA and init data, but
I don't understand these things. I see, the issue is not of high
priority,
so I'm ready to wait for the moment you will find a minute to clarify
starting point(s) for my next attempts to bugnote in more informative
manner :-)

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:48 CEST 
----------------------------------------------------------------------
My question is what do you mean 'silent' and 'empty' in your texts.

Are the all data in the recorded file value zero, or the no
(or shorter) data is recorded?  Or, the data values are not zero
but significantly small values?

All these three have different meanings.  The first case is usually
that the signal is not routed or processed in codec but the DMA is
running to get data.  The second case implies that the DMA is not
running or stopped due to lack of data.  The last one implies that
the signal is physically processed (and DMA running) but something
(e.g. digital attenuation) in codec is not set properly.  In the
case of SPDIF, the last one shouldn't happen, though.

----------------------------------------------------------------------
 ungod - 09-23-2004 20:40 CEST 
----------------------------------------------------------------------
One reason why the S/PDIF input might not work, is that the GPIO direction
pins are initialized the wrong way. In the 1.0.7rc1 drivers, they are
initialized to 0xBFFFFF or 1011 1111 ... 1111. However, there are only 23
GPIO pins, so why define directions for the 24th pin? Apparently the
driver use some imaginary GPIO23 for the Prodigy 7.1 card???

Anyway, GPIO22 is, according to both the driver (and my voltmeter), the
CS8415 CS pin. GPIO21 is the SPI MISO pin (in the driver they call it
CS8415_CDTO - quite misleading I think). With the current direction
settings the GPIO22 (CS) is input and GPIO21 (MISO) is output, but this is
wrong. So, by setting it to 5FFFF (0101 1111 ... 1111), the CS pin is
output and MISO is input.

I've changed it on my own computer, but I have actually not tested the
S/PDIF input before and after the change!

I've analysed what some commercial OSS drivers do, and they agree that
GPIO22 should be output and GPIO21 input

edited on: 09-23-04 20:40

----------------------------------------------------------------------
 ungod - 09-24-2004 04:14 CEST 
----------------------------------------------------------------------
Aside from the GPIO bug, it seems that the S/PDIF input is not connected to
RXP0 on the CS8415A as the driver assume, but to RXP1.

I've attached a patch (for 1.0.7rc1) which fixes the GPIO bug and uses
RXP1 instead of RXP0.

----------------------------------------------------------------------
 Andrew - 09-24-2004 10:11 CEST 
----------------------------------------------------------------------
About "silent" and "empty": I mean zero signal level in output
files. Files have length in accordance with recording time.

I have tried ice1724-spdif.diff with the same result.

----------------------------------------------------------------------
 tiwai - 09-24-2004 11:10 CEST 
----------------------------------------------------------------------
Could you provide a summary, description and a signed-off-by
for your patch, so that I can commit to CVS with changelog?

thanks.

----------------------------------------------------------------------
 ungod - 09-24-2004 13:44 CEST 
----------------------------------------------------------------------
I'm not that familiar with CVS rules for the coresponding Changelog, but I
assume you mean something like this:

Summary: Aureon S/PDIF input fixes

Description: Fix GPIO pin directions and use RXP1 instead of RXP0 as
S/PDIF source on CS8415A

Signed-off-by: Peter Christensen <peter@developers.dk>

----------------------------------------------------------------------
 ungod - 09-24-2004 13:51 CEST 
----------------------------------------------------------------------
By the way, it is most likely that the Aureon 7.1 Universe use more than
one RXP on the CS8415A. One for COAX, one for Optical etc., so it should
probably be a mixer setting or something. I can only test it for the
Aureon 7.1 Space which only has an optical input, and here RXP1 apparently
was the correct source.

As to no sound fra S/PDIF, I admit that the commercial OSS drivers
provided better S/PDIF in sound than the ALSA drivers, so the chips
CS8415A is probably not initialized entirely correct. And - are you using
the Universe og Space version of Aureon 7.1?

----------------------------------------------------------------------
 tiwai - 09-24-2004 14:32 CEST 
----------------------------------------------------------------------
I applied the patch to CVS now.
Thanks.

----------------------------------------------------------------------
 ungod - 09-24-2004 15:02 CEST 
----------------------------------------------------------------------
I noticed that the S/PDIF sound was kind of noise and ugly, so I modified
the init sequence of the CS8415A chip and got far better sound out of it
(don't know if it will affect you silence). If I should do a summary etc.
again:

Summary: Aureon S/PDIF input fixes

Description:
 GPIO directions changed
   * GPIO>22 not configured as they do not exist
   * GPIO22 set to output (CS8415A CS pin)
   * GPIO21 set to input. (SPI MISO pin)

 Init sequence of CS8415A changed:
  * SWCLK is set to 1 (OMCK output to RMCK pin)
  * MUX2:0 is set to 001 (S/PDIF input on RXP1)
  * SODEL is set to 1 (MSB of SDOUT data occurs if the second OSCLK period
after the OLRCK edge)
  * SOLRPOL is set to 1 (SDOUT data is for the right channel with OLRCK is
high)

Signed-off-by: Peter Christensen <peter@developers.dk>

The above is for ice1724-spdif2.diff which also does the work of
ice1724-spdif.diff

edited on: 09-24-04 15:02

----------------------------------------------------------------------
 tiwai - 09-24-2004 14:42 CEST 
----------------------------------------------------------------------
Ok, committed the new patch to CVS.

----------------------------------------------------------------------
 ungod - 09-25-2004 01:13 CEST 
----------------------------------------------------------------------
Argh! Dammit - I accidently typed a wrong E-mail address, and you managed
to add it to the CVS before I corrected it.

----------------------------------------------------------------------
 ungod - 09-29-2004 05:28 CEST 
----------------------------------------------------------------------
I've looked a bit closer on the Aureon card. Apparently RXP0 is the digital
CD input and RXP1 is optical on the Space model. On the universe it seems
that RXP1 is used for both optical and coax and some additional chip (on
the 5.25" bay) does the the Optical/Coax choice.

I personally only have the Space card, but if you have the Universe model,
this is most likely the reason why you will get no sound.

I've been working on adding S/PDIF input settings (So far a mute and a
Optical/CD in selection), but I don't really want to publish anything
until I know how it works on the Universe model.

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:54 CEST 
----------------------------------------------------------------------
I assume it's fixed.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 13:16 Andrew         New Bug                                      
08-25-04 19:55 tiwai          Bugnote Added: 0001625                       
08-25-04 23:47 Andrew         Bugnote Added: 0001628                       
08-27-04 19:39 tiwai          Bugnote Added: 0001648                       
09-07-04 10:33 Andrew         Bugnote Added: 0001706                       
09-08-04 17:16 tiwai          Bugnote Added: 0001734                       
09-08-04 17:55 Andrew         Bugnote Added: 0001737                       
09-23-04 18:48 tiwai          Bugnote Added: 0001832                       
09-23-04 20:34 ungod          Bugnote Added: 0001847                       
09-23-04 20:35 ungod          Bugnote Edited: 0001847                      
09-23-04 20:38 ungod          Bugnote Edited: 0001847                      
09-23-04 20:39 ungod          Bugnote Edited: 0001847                      
09-23-04 20:40 ungod          Bugnote Edited: 0001847                      
09-24-04 04:10 ungod          File Added: ice1724-spdif.diff                    
09-24-04 04:14 ungod          Bugnote Added: 0001854                       
09-24-04 10:11 Andrew         Bugnote Added: 0001859                       
09-24-04 11:10 tiwai          Bugnote Added: 0001860                       
09-24-04 13:44 ungod          Bugnote Added: 0001883                       
09-24-04 13:51 ungod          Bugnote Added: 0001884                       
09-24-04 14:32 tiwai          Bugnote Added: 0001885                       
09-24-04 14:36 ungod          Bugnote Added: 0001887                       
09-24-04 14:36 ungod          File Added: ice1724-spdif2.diff                    
09-24-04 14:42 tiwai          Bugnote Added: 0001888                       
09-24-04 15:02 ungod          Bugnote Edited: 0001887                      
09-25-04 01:13 ungod          Bugnote Added: 0001907                       
09-29-04 05:28 ungod          Bugnote Added: 0001966                       
10-12-04 14:54 tiwai          Bugnote Added: 0002100                       
10-12-04 14:54 tiwai          Assigned To               => tiwai           
10-12-04 14:54 tiwai          Resolution               open => fixed       
10-12-04 14:54 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
