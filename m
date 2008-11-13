From: Andrei Tanas <andrei@tanas.ca>
Subject: Re:
 =?utf-8?q?Asus_P5QL-EM_motherboard_=28ALC1200_codec?=
 =?utf-8?q?=29_-=09no=09sound_through_S/PDIF?=
Date: Thu, 13 Nov 2008 09:38:37 -0500
Message-ID: <c11e940b1b3df5cb95e63f38b1b54416@localhost>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de> <s5htzacqbg8.wl%tiwai@suse.de>
	<5cc3284c7cc701236ffb50fffa632d8e@localhost>
	<s5hk5b7hf9y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 47DAD24572
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 15:38:39 +0100 (CET)
In-Reply-To: <s5hk5b7hf9y.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

One unexpected thing is that "PCM Out" is not listed as a capability of
IEC958 control (as shown by amixer):

Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

Is that normal?
