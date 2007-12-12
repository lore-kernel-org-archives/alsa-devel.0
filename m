From: Steve Strobel <steve.strobel@link-comm.com>
Subject: Using dmix/dsnoop/dshare to access individual channels
Date: Wed, 12 Dec 2007 16:04:37 -0700
Message-ID: <0MKp8S-1J2adg1age-0007la@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	by alsa0.perex.cz (Postfix) with ESMTP id CEAFC245B3
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 00:05:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using a 4-input, 8-output codec (AD1938) in an application similar to a live sound mixing 
board, where a combination of the input signals get mixed for each output.  I can mix four 
inputs to four outputs with a command like:

        arecord --file-type raw --channels=4 --format=S32_LE --rate=16000 \
         | crosspoint \
         | aplay  --file-type raw --channels=4 --format=S32_LE --rate=16000

where crosspoint is a simple program that reads from stdin, does some mixing, and outputs 
to stdout.

My next step is to play and record wave files from the various channels, while the crosspoint 
is running.  For example, I might need to play message1.wav to channel 2 and message2.wav 
to channel 3 while recording channel 1 to message3.wav.  I am looking for advice about the 
best way to accomplish that.

It seems like it should be possible using a combination of dmix, snoop, and dshare, as follows:
  - Use dsnoop to split the 4-channel input to the crosspoint and another virtual sound input, call it "A".
  - Use dshare to split "A" into four mono sources.  Then can use arecord normally to capture wave files.
  - Use dmix and possibly dshare to similarly let the crosspoint continue to use the multi-channel 
    output while also providing a mono sound device for each channel that I can use with aplay.

Am I on the right track, or would I be better off adding functionality to the crosspoint application 
to read and write wave files?  Thanks for any suggestions.

Steve


---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com
