From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
Date: Thu, 11 Mar 2010 08:30:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003110824390.4672@eeebox2.perex-int.cz>
References: <s5htyswpb18.wl%tiwai@suse.de> <s5hvddcnlr6.wl%tiwai@suse.de>  <6B4D417B830BC44B8026029FD256F7F1C16B1AD558@HKMAIL01.nvidia.com>  <a3ef07921003071121r24979a0breac27e3b0475bbcb@mail.gmail.com>  <6B4D417B830BC44B8026029FD256F7F1C16B1AD562@HKMAIL01.nvidia.com>
  <20100308044614.GA29026@localhost>  <a3ef07921003092142g23b93903v2b4af9c6b691bea0@mail.gmail.com>  <alpine.LNX.2.00.1003100856420.4672@eeebox2.perex-int.cz>  <a3ef07921003100005k6c7da149k99069cc13b3c8183@mail.gmail.com>  <20100310125456.GA18509@localhost>
 <a3ef07921003100938o4d94161fw559bc9b563ce55b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a3ef07921003100938o4d94161fw559bc9b563ce55b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: VDR User <user.vdr@gmail.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>, Wei Ni <wni@nvidia.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <jkysela@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Mar 2010, VDR User wrote:

> [pid 22651] ioctl(21, 0x80044121, 0xb439d2cc) = -1 EPIPE (Broken pipe)
> pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed.

-EPIPE means underrun condition.

Try 'echo 101 > /proc/asound/card0/pcm0p/xrun_debug' and send dmesg 
output to check if the ring buffer pointer in the hda-intel driver does 
not return wrong values. Replace card0 and pcm0p with right identifiers 
(look to 'aplay -l' for right numbers).

More info: http://www.alsa-project.org/main/index.php/XRUN_Debug

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
