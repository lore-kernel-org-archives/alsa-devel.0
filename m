From: Jonathan Gardner <jgardner@jonathangardner.net>
Subject: Gigabyte 880GM-USB3 MIDI and Dolby 5.1/7.1 issues
Date: Thu, 9 Dec 2010 03:16:02 -0800
Message-ID: <AANLkTimb5AnPm13d0kpMmjq4nOTH0dXA_VyO2CXbr_bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f193.google.com (mail-qy0-f193.google.com
	[209.85.216.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 895AE103C77
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 12:16:03 +0100 (CET)
Received: by qyk5 with SMTP id 5so540708qyk.8
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 03:16:02 -0800 (PST)
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

I'm a developer who spends most of his time in Python writing web apps
but I know my way around C. I've been using Linux for over 10 years
now and I thought it's time to get serious about making Linux work for
the hardware I use. I'm self-employed now, so I don't have to deal
with any legal departments and can help out to my heart's desire.

Disclaimer: I intend to learn how to help debug these issues and hack
on some fairly low-level pieces of software and get a clear sense of
how hardware really works. Mostly this is a "scratch-my-own-itch"
thing, but it's always bothered me that I've never truly understood
what happens below the KDE interface.

I recently bought a Gigabyte 880GM-USB3 motherboard.
http://www.gigabyte.us/products/product-page.aspx?pid=3412#sp I think
"Realtek ALC892" describes the hardware for audio.

I'm running Fedora 13 with KDE which seems to have alsa 1.0.23 running.

I don't know much about hardware or audio, but I do know that it's not
working 100% for me with this motherboard. There are two issues that
stand out.

First, with my older motherboard, I could control the various output
and input levels of the channels. With this motherboard, I only have
one channel "Internal Audio Analog Stereo". This board is supposed to
support up to Dolby 7.1 surround sound. I want to make this computer
my hub for all my devices. Obviously this isn't possible.

Second, I never really got MIDI working, at least not that I recall in
my 10 years of Linux. I know MIDI is possible, I just don't know what
it takes. I've been playing with musescore which apparently plays the
notes over MIDI so you can hear what you wrote, which would be nice.

RTFM is certainly acceptable advice, if you can show me which FM is
preferred. I'll also write some documentation if it helps.

-- 
Jonathan Gardner
jgardner@jonathangardner.net
