From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for sram-support-less
 platforms
Date: Tue, 2 Oct 2012 14:07:20 +0530
Message-ID: <506AA7C0.5080300@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120922153313.GN4495@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Porter, Matt" <mporter@ti.com>, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, davinci-linux-open-source@linux.davincidsp.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 9/22/2012 9:03 PM, Mark Brown wrote:
> On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:
> 
>> +config SND_DAVINCI_HAVE_SRAM
>> +	bool
>> +	default y if ARCH_DAVINCI=y
>> +	default n if ARCH_OMAP=y
>> +
> 
> I've been sitting on this mostly since it seems like a step back from
> multi-platform kernels (which is where we're trying to get to) and I've
> been trying to decide what the best approach is.  I'm thinking that we
> do want a generic API for allocating this stuff, it's a fairly generic
> feature (there's TCMs as well).  
> 
> Adding ifdefs like this does just doesn't seem good.

How about converting to use genalloc instead of the DaVinci private SRAM
API and passing the pool to be used via platform data?

Matt Porter just used this approach to make the uio PRUSS driver usable
on both DaVinci and AM335x. It suffered from the exact same problem.

https://patchwork.kernel.org/patch/1522481/

Thanks,
Sekhar
