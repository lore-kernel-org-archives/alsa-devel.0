From: Monty Montgomery <xiphmont@gmail.com>
Subject: A problem with USB audio devices and the UHCI scheduler
Date: Fri, 29 Jun 2012 21:05:48 -0400
Message-ID: <CACrD=+8BOOb=17Qs5k_2jZeEf_+N3U1dq2sm0PtwrWxkrouRLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id D05E42445D
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 03:05:48 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so3159917bkc.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2012 18:05:48 -0700 (PDT)
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

A question for Clemens et al...

Background: I can run a USB audio device at 6ch/24 bit single duplex,
but I cannot run the same device at 16 bit stereo full duplex.  UHCI
and EHCI both say 'not enough bandwidth' (OHCI works).

EHCI's scheduling issues are well known, but I was surprised UHCI
could not schedule this either.  The cause is simple; UHCI (and EHCI)
use the endpoint's wMaxPacketSize for all bandwidth allocation.  My
device supports all of its sample rates on the same altset, with a
wMaxPacketSize matching the highest (96kHz) rate.  So, the HCD is
reserving most of the USB bus's bandwidth regardless of the actual
requirements.

How should I approach fixing this in the driver? There's currently no
means to communicate a desired bandwidth reservation to the HCD from
USB audio, so I'd have to extend even the quirks.  I was considering
shadowing the endpoint's original wMaxPacketSize in the substream
struct, and replacing the value in the endpoint's native descriptor
while the stream is running.  I have no idea how much trouble that would
cause (eg, corruption elsewhere, or middle finger from Linus).

Suggestions? For now I have things working by disabling UHCI's initial
bandwidth checks (as there is in fact more than enough bandwidth to
schedule what I'm doing) but I'd like a more permanent solution.

Monty
