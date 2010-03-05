From: Daniel Mack <daniel@caiaq.de>
Subject: usb-audio code refactoring, more v2 support [resend]
Date: Fri,  5 Mar 2010 08:41:17 +0100
Message-ID: <1267774885-16266-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 47F0D103847
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 08:41:50 +0100 (CET)
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This is a rebased version of the usb-audio cleanup patch set.
On top of what's already been posted, there is one more fix to support
sample rate configuration, and one bugfix.

Commit 864c11080 was also ported over. And Clemens' latest patches
are also included.

With these patches applied, I can stream audio on a class v2 device.
At least for awhile, then I get CRC errors in DATA0 packets. But
that's a different issue.

What's not yet done is all the feature unit parsing, mixers etc.

Daniel

[PATCH 1/8] ALSA: usb-audio: move ua101 driver
[PATCH 2/8] ALSA: usb-audio: header file cleanups
[PATCH 3/8] ALSA: usb-audio: refactor code
[PATCH 4/8] ALSA: usb-audio: rename substream format field to altset_idx
[PATCH 5/8] ALSA: usb-audio: use a format bitmask per alternate setting
[PATCH 6/8] ALSA: usb-audio: support multiple formats with audio class v2 devices
[PATCH 7/8] ALSA: usb-audio: add support for samplerate setting on v2 devices
[PATCH 8/8] usb/audio.h: Fix field order
