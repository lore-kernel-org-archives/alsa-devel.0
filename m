From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: info: Check for integer overflow in
 snd_info_entry_write()
Date: Thu, 16 Aug 2018 12:07:05 +0200
Message-ID: <20180816100705.GC9141@kroah.com>
References: <20180816005548.151269-1-erickreyes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180816005548.151269-1-erickreyes@google.com>
Sender: stable-owner@vger.kernel.org
To: Erick Reyes <erickreyes@google.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel-team@android.com, Vinod Koul <vkoul@kernel.org>, Joe Perches <joe@perches.com>, Al Viro <viro@zeniv.linux.org.uk>, alsa-devel@alsa-project.org, Siqi Lin <siqilin@google.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 15, 2018 at 05:55:48PM -0700, Erick Reyes wrote:
> Commit 4adb7bcbcb69 ("ALSA: core: Use seq_file for text proc file
> reads") heavily refactored ALSA procfs and fixed the overflow as
> a side-effect, so this fix only applies to kernels < 4.2 and
> there is no upstream equivalent

Thanks for the patch.  I'll queue this up for 3.18.

greg k-h
