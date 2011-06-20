From: David Henningsson <david.henningsson@canonical.com>
Subject: Jack event API - decision needed
Date: Mon, 20 Jun 2011 15:37:25 +0200
Message-ID: <4DFF4D15.6050809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D11624435
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 15:37:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, broonie@o
List-Id: alsa-devel@alsa-project.org

Hi,

I'm still new in the community in that sense that I'm not sure how 
decisions are made. But I could use the outcome of such a decision.

Background: I'm trying to pull together the missing pieces of jack 
detection on both kernel / plumbing / application layers, so that when 
you plug something in (headset, microphone etc), userspace is notified 
and can take appropriate actions (e g routing decisions).

As part of that I wrote a udev patch a few days ago, which nobody 
commented on in alsa-devel [1], but was somewhat disliked by at least 
Kay Sievers who maintains udev [2], who preferred we would rewrite our 
input layer to do something else within ALSA.

So before I proceed further I'd like to know if

1) We're continuing the path with /dev/input devices

2a) We'll rewrite these devices to be read-only ALSA mixer controls

2b) We'll rewrite these devices to be something within ALSA, but not 
exactly mixer controls.

For options 2a) and 2b) I guess the existing /dev/input thing should be 
deprecated and/or removed. So part of decision should maybe be based on 
information about how widespread the usage of these devices are 
currently...?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-June/040916.html

[2] e g http://www.spinics.net/lists/hotplug/msg04949.html
