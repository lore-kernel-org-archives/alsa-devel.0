From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] ALSA: au88x0: pr_* replaced with dev_*
Date: Thu, 09 Oct 2014 23:20:52 -0700
Message-ID: <1412922052.8770.14.camel@joe-AO725>
References: <1412847397-4292-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <1412847397-4292-2-git-send-email-sudipm.mukherjee@gmail.com>
	 <s5hd2a1tlb2.wl-tiwai@suse.de> <1412864283.3438.43.camel@joe-AO725>
	 <20141010061702.GA4431@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141010061702.GA4431@sudip-PC>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-10-10 at 11:47 +0530, Sudip Mukherjee wrote:
> if we remove the prefix then we will not get the exact card name.
> dev_* will print the device name as CARD_NAME_SHORT which will be
> au8810 or au8820 or au8830. 
> so, now waiting for your suggestion ..

I think the au88x0 prefix is sufficient.
