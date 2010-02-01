From: Dougall Irving <dougall.irving@versonic.com>
Subject: RME HDSPe Raydat
Date: Mon, 1 Feb 2010 16:27:50 +0800
Message-ID: <ac7eefbd1002010027g49148edfm45957d39b921b973@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 90B0724450
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 09:27:51 +0100 (CET)
Received: by iwn27 with SMTP id 27so480566iwn.8
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 00:27:50 -0800 (PST)
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

I've been trying to get an RME HDSPe Raydat working.  I've installed
the latest firmware on the card using the Windows firmware uploader.
The stock hdspm module in ALSA version 1.0.22.1 doesn't work
correctly.

The first problem I found is that external ADAT equipment were not
able to sync with RME adat outputs.  Following some old alsa code
posted on another site, I changed the HDSPM_freqReg to 100 MHz
(instead of 105) and found that I could get external equipment to sync
to the raydat at 48kHz.

The second issue I had was the audio output was turning on and off
every second.  I found if I changed the .params to only use float 32
instead of int 32 and I forced the card to use precise pointer I could
get continuous audio but only with larger buffer sizes.  I get a quite
a few buffer underruns also.  With smaller buffer sizes I get silence.

There is a comment in the code which don't follow.  I wonder if there
is an issue with this code....

/* hwpointer comes in bytes and is 64Bytes accurate (by docu since
	   PCI Burst)
	   i have experimented that it is at most 64 Byte to much for playing
	   so substraction of 64 byte should be ok for ALSA, but use it only
	   for application where you know what you do since if you come to
	   near with record pointer it can be a disaster */

	position &= HDSPM_BufferPositionMask;
	position = ((position - 64) % (2 * hdspm->period_bytes)) / 4;


Does anyone have any suggestions or ideas for debugging these
problems?  Is there any information RME from available?

Alternatively, has anyone had success with this card and earlier
firmware revisions?
