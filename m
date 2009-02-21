From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Standard mixer control names
Date: Sun, 22 Feb 2009 00:36:30 +0100
Message-ID: <20090221233629.GA3748@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AD2E24472
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 00:36:32 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

I'd like to add functionality to PulseAudio to allow a simplified
selection of capture input (i.e. "Mic", "Line-In", ...) and playback
outputs ("Headphones", "Line-Out", ...) for ALSA cards. By
"simplified" I mean that only one input and output shall be active at
a time. Also, some more nonsense items shall be filtered out
(i.e. recording from "Phone"). Hence, basically I want to compile a
list of available and whitelisted inputs and outputs and allow the
user to select exactly one from each.

ALSA is making that very hard to implement something like this because
every driver seems to wrap input/output selection differently.

On one card I have only has a couple of cswitches
(snd-es1371). The same one has an enum "Mic Select". Another card has
an enum "Input Source", but no cswitches (a HDA chip). The
"ControlNames.txt" file in the kernel seems to suggest that there is an
element "Capture Source".

For playback it seems that some cards have a a headphone switch, and
others a headphone slider (which i guess makes sense).

Now, the question, how should I implement this?

For playback the handling is easy as long as there is only one element
to deal with, but what about capture? One option would be to simply
go by cswitch and nothing else. Or go by "Input Source" and nothing
else. Or combine some form. Now I'd of course prefer if the drivers
get fixed to use a single element naming scheme only. Is there any
chance to get that? And which one would that be?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
