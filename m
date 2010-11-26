From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] ALSA: patch_realtek: handle unset external amp bits
Date: Fri, 26 Nov 2010 08:29:22 -0500
Message-ID: <20101126132922.GO22651@bombadil.infradead.org>
References: <20101125185730.GK22651@bombadil.infradead.org>
 <s5h8w0gskds.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8w0gskds.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kyle McMartin <kyle@mcmartin.ca>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 06:51:11AM +0100, Takashi Iwai wrote:
> How about setting default to ALC_INIT_DEFAULT instead like the patch
> below?  This is safer than forcing ALC_INIT_DEFAULT to all, I
> suppose.
> 

As I understand the code, that should work fine. I'll build a new kernel
for my tester to confirm, I suspect it will though. :)

Thanks!
--Kyle
