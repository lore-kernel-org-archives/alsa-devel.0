From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device Tree support
Date: Thu, 31 Jan 2013 10:09:37 -0700
Message-ID: <510AA551.30400@wwwdotorg.org>
References: <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <20130131013500.GA4759@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130131013500.GA4759-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/30/2013 06:35 PM, Mark Brown wrote:
> On Wed, Jan 30, 2013 at 01:14:07PM -0700, Stephen Warren wrote:
> 
>>> +CPU / CODEC DAI is represented as a sub-node. +Then, sub-node
>>> name should be "simple-audio,cpu" or "simple-audio,codec".
> 
>> Why require sub-nodes? it seem over-complex.
> 
> I suggested this because it seemed more legible to repeat the
> properties by having a named structure for each property rather
> than by repeating them all with slightly different names.

So the only need to repeat them at all was if the two DAIs needed
different values for some of the properties rather than being
identical (e.g. signal polarity) or precise inversions (e.g. which end
is master), right?

Is that actually likely - I can understand that for e.g. plain old
GPIOs board designers might end up sticking random inverters between
two devices for various reasons, but surely this wouldn't happen for
an I2S interface where the polarities etc. mean something relative to
the other signals? I would almost argue that since the simple case is
for the signals to be connected 1:1 between the two DAIs, that if a
particular board doesn't conform to that, it isn't a simple-audio
case. That all said, we could extend simple-audio to handle it still
without duplicating everything by specifying the DAI format for the
CPU DAI once in the simple-audio node, "inverting" that when
configuring the CODEC DAI, and then adding extra boolean properties to
the DT later in a backwards-compatible fashion, for any strange cases
the driver can end up handling.
