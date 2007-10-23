From: Timur Tabi <timur@freescale.com>
Subject: Confused about 'default' device
Date: Tue, 23 Oct 2007 14:40:26 -0500
Message-ID: <471E4E2A.9090105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E04824A53
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 21:40:40 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9NJeQLb023103
	for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2007 12:40:37 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9NJeQnK029916
	for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2007 14:40:26 -0500 (CDT)
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

I'm having a hard time understand when ALSA does sample rate and format 
conversion, and when it doesn't.

When I issue the following command:

	mplayer -ao alsa filename.mov -v

I get this output:

Building audio filter chain for 48000Hz/2ch/s24le -> 0Hz/0ch/s8...
[libaf] Adding filter dummy
[dummy] Was reinitialized: 48000Hz/2ch/s24le
[dummy] Was reinitialized: 48000Hz/2ch/s24le
alsa-init: requested format: 48000 Hz, 2 channels, 11
alsa-init: using ALSA 1.0.8
alsa-init: setup for 1/2 channel(s)
alsa-init: using device default
alsa-init: pcm opend in blocking mode
alsa-init: format s24le are not supported by hardware, trying default
alsa-lib: pcm_plug.c:729:(snd_pcm_plug_hw_refine_schange) Unable to find
an usable access for 'default'
alsa-init: unable to set format: Invalid argument

Sure enough, my device can't handle s24le.  It can only handle s16be.

I was under the impression that ALSA can do format and sample rate conversion if 
necessary, but I guess that's not always the case.  I know ALSA has a bunch of 
plug-ins for that, but I guess they're not used by default.

What do I need to do to tell ALSA to convert s24le to s16be?
