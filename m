From: Mourad De Clerck <bugs-alsa@aquazul.com>
Subject: hda: MacBookPro7,
	1: no sound on left channel of 'Surround Speaker'
Date: Wed, 01 Jun 2011 01:26:14 +0200
Message-ID: <4DE57916.5040208@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gretel.risen.be (gretel.risen.be [78.46.99.137])
	by alsa0.perex.cz (Postfix) with ESMTP id E26402414A
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 01:26:15 +0200 (CEST)
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

Hi,

My MacBookPro7,1 (nVidia MCP89) has a problem with the sound on its
internal speakers.

The 'Front Speaker' works properly, but is quite "thin" and quiet. The
'Surround Speaker' completes the volume level properly, but only the
right channel works. Switching 'Surround Speaker' on/off for both
left/right, or manipulating the 'Surround Speaker Playback Volume' only
has an effect on the right channel, the left stays silent.

It'd be nice if someone could provide me a patch or some guidance for
patch_cirrus.c so we can fix this.

Thanks,

Mourad

PS: here are the relevant mixer controls. (is there a reason why the
surround switch and volume are separated?)

--

Simple mixer control 'Front Speaker',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 115
  Mono:
  Front Left: Playback 115 [100%] [0.00dB] [on]
  Front Right: Playback 115 [100%] [0.00dB] [on]
Simple mixer control 'Surround Speaker',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Surround Speaker Playback Volum',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 115
  Front Left: 115 [100%]
  Front Right: 115 [100%]
