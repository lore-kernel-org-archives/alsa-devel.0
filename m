From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Re: Via VT82xx VT1708 ICE1724HT and higher
Date: Tue, 26 Feb 2008 22:46:33 -0800
Message-ID: <407BA13ECBE04CED8BA6759222C21406@DemianM1330>
References: <mailman.2073.1204045163.2095.alsa-devel@alsa-project.org>
	<004401c878a2$6cade570$d450a8c0@PDSMain2>
	<47C47AF8.1070005@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n22.bullet.mail.mud.yahoo.com (n22.bullet.mail.mud.yahoo.com
	[68.142.200.113]) by alsa0.perex.cz (Postfix) with SMTP id 64F572454D
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 07:46:38 +0100 (CET)
In-Reply-To: <47C47AF8.1070005@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Pavel Hofman' <pavel.hofman@insite.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel:

1) I'm using a Juli@ card with the apparently non functional driver. I get
similar results with the VT1708 however. At 44.1 and 48 I can get good
output at 24 bit audio with the plughw:0,1. At higher bit rates no sound
comes out. At 96 KHz I get broadband noise. 

2) The Plug plugin would be configured thus I think:

pcm.!default {
        type plug
        slave {
                pcm "hw:0,1"
        }
}

ctl.mixer0 {
    type hw
    card 0
}

But I get this:

linuxmce@dcerouter:~$ aplay -vv
/home/public/data/audio/gimell-test-flac-24-96000.wav
Playing WAVE '/home/public/data/audio/gimell-test-flac-24-96000.wav' :
Signed 24 bit Little Endian in 3bytes, Rate 96000 Hz, Stereo
Plug PCM: Linear conversion PCM (S32_LE)

And no recognizable sound on either the Juli@ or the Via CX700 at higher bit
depth than 16. And I'm getting underruns on a 44.1/16 wav file on the Via
platform.

Possibly both drivers are giving incorrect parameters for SPDIF data
streams? (32 bit when it should be 24 bit for SPDIF?) For what its worth I
found this detail on the SPDIF format:
http://www.epanorama.net/documents/audio/spdif.html which is simpler and
more condensed than the Crystal documentation. In a day I should have some
time to look at what is actually coming out of the card after decoding by a
crystal receiver.
This is Alsa 1.0.14 as included with Ubuntu 710
      -Demian

-----Original Message-----
From: Pavel Hofman [mailto:pavel.hofman@insite.cz] 
Sent: Tuesday, February 26, 2008 12:48 PM
To: Demian Martin
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Via VT82xx VT1708 ICE1724HT and higher

Demian Martin wrote:
> I tried your suggestion to use plughw:0,1  and the verbose output looks
> fine, the data rate shifts fine (I'm watching the L/R clock on the input
to
> the DAC on an external DAC)  but no audible sound comes out the converter
> unless it's a 16 bit 44.1 file. The 24 bit stuff is not getting converted
> into something useful to the DAC. Should I check to see if the data clock
is
> 48X the LR clock? 
 >
 > What info do you need from me to look deeper?

Which card are you using? Juli driver in alsa is not really functional. 
E.g. Prodigy 192 (standard clock arrangement) has no problem with 24bit 
SPDIF-OUT.

> 
> I looked at the Plug plugin but have not been able to figure out how to
> configure it for my needs. There is way too much marginal information on
the
> web and little that directs me to an optimum setting.
>                            -Demian
> 

I do not think the plug plugin needs any configuration. It compares 
input stream parameters with the card capabilities supplied by the 
driver and does appropriate conversions.

Pavel.

No virus found in this outgoing message.
Checked by AVG Free Edition. 
Version: 7.5.516 / Virus Database: 269.21.0/1296 - Release Date: 2/24/2008
12:19 PM
