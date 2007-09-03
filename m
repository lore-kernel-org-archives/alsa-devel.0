From: Trent Piepho <xyzzy@speakeasy.org>
Subject: How to name controls
Date: Mon, 3 Sep 2007 14:46:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709031409580.18152@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10]) by alsa0.perex.cz (Postfix) with ESMTP id 953A81037EB
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 23:46:14 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 3 Sep 2007 21:46:11 -0000
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

I'm trying to improve the audio controls for the cx88-alsa driver, but I'm
not sure what names I'm supposed to use.

Currently, the driver has a single control called "Capture Volume", but it
doesn't adjust the volume of the captured audio, so I don't think this name
is correct.

The audio routing looks something like this.  Keep in mind that this is a
TV capture chip and the drviers only support audio capture, not playback.

Analog In       Source Mute
 VV                  V
 ||                  |
 ||     o-----o      |
 ||     |     |    ----
 \`=====| ADC |----|  |---+------------------------> Audio DMA
        |     |    ----   |
        o-----o           |
                        -----
  Digital Volume________\   /
                         \ /
                          V           o-----o
                          |    ----   |     |
                          \----|  |---| DAC |======> Analog Out
                               ----   |     |
  DAC Mute-----------------------^    o-----o


Basically, there is an analog input (from the TV tuner), and a line out.
The analog input goes through ADC -> DAC steps and then to the line out.
There are three controls, one volume and two mute switches.  One switch
causes the source to be muted, the other only mutes the line out.  The
volume only controls the line out.

So what should I call these controls?  Do I call the volume "Playback
Volume"?  The chip doesn't support playback, so that seems confusing.  It's
more like "Pass-through Volume", but that's not an option.  And what do I
call the source mute switch?  "Capture Switch"?  That doesn't seem quite
right either, since it doesn't just mute capture, but also mutes the
pass-through audio.
