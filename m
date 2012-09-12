From: Timur Tabi <timur@freescale.com>
Subject: Need help with WM8960
Date: Wed, 12 Sep 2012 18:09:00 -0500
Message-ID: <5051160C.2010802@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A8F2616F9
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 01:09:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,

I'm trying to port some old Linux code to upstream for a third-party board
that uses a Freescale P1022 and a Wolfson WM8960. I've got audio working,
but it's using a hack from the third-party code, and I don't know how to
do implement the change properly, mostly because I don't understand DAPM.

The first problem is that I get this:

	wm8960 0-001a: No platform data supplied

What kind of platform data is the driver expecting, and how do I get it
that data?  I don't seem to need any platform data to make the code work.

Second, I uploaded the hack to wm8960.c at http://pastebin.com/RwVy6cQg

You can see that he disables the DAPM controls for DACL, DACR, ADCL, and
ADCR, and forces those bits set in the wm8960_probe function.  There's
also a comment that documents some limitations.  What is the proper way to
implement this change?

Third, in order to actually hear audio, I had to unmute the "Left Output
Mixer PCM" and "Right Output Mixer PCM".  Is this something that the
machine driver should do automatically?  And if so, how?

-- 
Timur Tabi
Linux kernel developer at Freescale
