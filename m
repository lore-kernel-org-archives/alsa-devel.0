From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1
 vulnerabilities
Date: Thu, 20 Dec 2018 11:51:59 -0600
Message-ID: <16ea3722-c1e7-b82a-2708-e26132ed7c78@embeddedor.com>
References: <20181219233143.GA14518@embeddedor> <s5ha7l0obxk.wl-tiwai@suse.de>
 <c367ab0f-6b07-fa4f-0e05-0050a02875ae@embeddedor.com>
 <s5hlg4km77z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlg4km77z.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 12/20/18 11:35 AM, Takashi Iwai wrote:

> 
> Well, no, my question is whether it makes sense to patch the code path
> for such ISA drivers.  Spectre seems applicable since the model around
> 2006 or so, and ISA slot has been already dead for very long time.
> And yet with this minor board...  I bet no one hits this in the
> world.
> 

Oh, I see.  I'm not stopping to analyze all the context around a driver 
other than the code itself.  So, thanks for pointing this out. I won't 
touch those drivers from now on.

Thanks
--
Gustavo
