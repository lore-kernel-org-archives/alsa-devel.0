From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hda_intel: too quiet sound (regression)
Date: Mon, 26 Jul 2010 16:48:20 +0200
Message-ID: <4C4DA034.3090608@gmail.com>
References: <4C4D9EDA.3060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6606924154
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 16:48:23 +0200 (CEST)
Received: by bwz4 with SMTP id 4so3003738bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 07:48:23 -0700 (PDT)
In-Reply-To: <4C4D9EDA.3060505@gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, fengguang.wu@intel.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/26/2010 04:42 PM, Jiri Slaby wrote:
> Hi,
> 
> after I upgraded from 2.6.34-rc5-mm1 to 2.6.35-rc5-mm1 (there were other
> issues in between them), the sound from my soundcard is very very quiet.
> 
> alsa-info:
> http://www.alsa-project.org/db/?f=dcadb29a2d5d047ecf5545792ac3239dc0c8c7f0
> 
> Any ideas?

I've just find out that whatever value 1-64 is set the Master control to
via amixer, it plays still the same. So the mixer (Master volume) is
somehow screwed up.

These two are the same volumes:
# amixer -D hw sset Master,0 64
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
# amixer -D hw sset Master,0 1
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 1 [2%] [-47.25dB] [on]



This turns sound off, indeed:
amixer -D hw sset Master,0 0
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [-48.00dB] [on]

regards,
-- 
js
