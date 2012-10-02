From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
Date: Tue, 02 Oct 2012 15:42:47 +0200
Message-ID: <506AEF57.2000306@gmail.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com> <506A9C65.5040309@ti.com>
 <20121002093753.GU4360@opensource.wolfsonmicro.com>
 <506AC303.9080906@gmail.com> <506ACACE.4030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <506ACACE.4030308@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, davinci-linux-open-source@linux.davincidsp.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 02.10.2012 13:06, Sekhar Nori wrote:
> On 10/2/2012 4:03 PM, Daniel Mack wrote:
>> On 02.10.2012 11:37, Mark Brown wrote:
>>> On Tue, Oct 02, 2012 at 10:48:53AM +0300, Peter Ujfalusi wrote:
>>>
>>>> I also agree that ifdef is not a good solution.
>>>> It is better to have this information passed as device_data and via DT it can
>>>> be decided based on the compatible property for the device.
>>>
>>> That's not really the problem here - the problem is that the APIs used
>>> to get the SRAM are DaVinci only so it's not possible to build on OMAP
>>> or other platforms.  The SRAM code needs to move to a standard API.
>>
>> What about following Matt Porter's idea and ignore the SRAM code
>> entirely and port the entire PCM code to generic dmaengine code first?
>> The EDMA driver needs to learn support for cyclic DMA for that, and I
>> might give that a try in near future.
>>
>> Later on, the SRAM ping-pong code can get added back using genalloc
>> functions, as Sekhar proposed. That needs to be done by someone who has
>> access to a Davinci board though, I only have a AM33xx/OMAP here.
> 
> We cannot "get rid" of SRAM code and add it back "later". It is required
> for most DaVinci parts. The SRAM code can be converted to use genalloc
> (conversion should be straightforward and I can help test it) and the
> code that uses SRAM can probably keep using the private EDMA API till
> the dmaengine EDMA driver has cyclic DMA support. Matt has already
> posted patches to move private EDMA APIs to a common location. That
> should keep AM335x build from breaking. Is this something that is feasible?

Yes - by "later" I just meant in a subsequent patch. But you're probably
right, we can also do that first.

I'm looking at that right now and the problem seems that we don't have a
sane way to dynamically look up gen_pools independently of the actual
run-time platform. All users of gen_pools seem to know which platform
they run on and access a platform-specific pool. So I don't currently
see how we could implement multi-platform code, gen_pools are fine but
don't solve the problem here.

Would it be an idea to add a char* member to gen_pools and a function
that can be used to dynamically look it up again? If a buffer with a
certain name exists, we can use it and install that ping-pong buffer,
otherwise we just don't. While that would be easy to do, it's a
tree-wide change.

Is there a better way that I miss?


Daniel
