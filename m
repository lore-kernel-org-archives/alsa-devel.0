From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ALSA: korg1212: cleanup of printk
Date: Mon, 10 Nov 2014 12:50:26 +0530
Message-ID: <20141110072026.GA12553@sudip-PC>
References: <1415603671-12510-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415603671-12510-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hi Takashi,
I have a doubt regarding this korg1212.
snd_korg1212_free_pcm is just making korg1212->pcm as NULL. But are we not supposed to release the allocated memory ?
in snd_pcm_new we are allocating memory.

thanks
sudip
