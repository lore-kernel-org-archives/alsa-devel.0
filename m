From: Helge Hafting <helge.hafting@ntebb.no>
Subject: Re: [alsa-devel] 3.6.0 regression, distorted sound failure while
 using jack and hd-audio
Date: Sat, 20 Oct 2012 11:24:02 +0200
Message-ID: <20121020112402.0f1119e5@tenkende-august.homelinux.net>
References: <20121007213452.08e29880@tenkende-august.homelinux.net>
	<5071F3CF.8070907@gmail.com>
	<s5h626ljgc7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h626ljgc7.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Mack <zonque@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 08 Oct 2012 14:31:04 +0200
Takashi Iwai <tiwai@suse.de> wrote:


> This sounds like a known issue that has been fixed for 3.7-rc1.
> As a workaround, try to pass position_fix=2 option to snd-hda-intel
> module.

Thanks a lot, that parameter fixed it for me. It was not necessary before,
and I'll try to remove it again for 3.7

Helge Hafting
