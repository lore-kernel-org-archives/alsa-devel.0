From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000453]: it is impossible to select spdif as capture source
Date: Thu, 23 Sep 2004 20:34:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923183412.D6D963E010@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 497B0326
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 20:34:13 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000453
======================================================================
Reported By:                Andrew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     453
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-18-2004 13:16 CEST
Last Modified:              09-23-2004 20:34 CEST
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
 ungod - 09-23-2004 20:34 CEST 
----------------------------------------------------------------------
One reason why the S/PDIF input might not work, is that the GPIO direction
pins are initialized the wrong way. In the 1.0.7rc1 drivers, they are
initialized to 0xBFFFFF or 1011 1111 ... 1111. However, there are only 23
GPIO pins, so why define directions for the 24th pin? Apparently the
driver use some imaginary GPIO24 for the Prodigy 7.1 card???

Anyway, GPIO22 is, according to both the driver (and my voltmeter), the
CS8415 CS pin. GPIO21 is the SPI MISO pin (in the driver they call it
CS8415_CDTO - quite misleading I think). With the current direction
settings the GPIO22 (CS) is input and GPIO21 (MISO) is output, but this is
wrong. So, by setting it to 5FFFF (0101 1111 ... 1111), the CS pin is
output and MISO is input.

I've changed it on my own computer, but I have actually not tested the
S/PDIF input before og after the change!

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
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
