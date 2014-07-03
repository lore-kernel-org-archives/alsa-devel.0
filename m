From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 03 Jul 2014 20:23:16 +0200
Message-ID: <53B59F94.6040803@metafoo.de>
References: <20140701164134.GH2296@intel.com> <53B400DE.3040205@baylibre.com>
 <20140703064147.GK2296@intel.com> <53B539E8.1000301@baylibre.com>
 <53B53C6B.8020707@metafoo.de> <53B540EE.30009@baylibre.com>
 <53B541F0.1040105@metafoo.de> <53B5428F.9050100@baylibre.com>
 <20140703120613.GP2296@intel.com> <20140703121846.GB410@sirena.org.uk>
 <20140703161517.GQ2296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-175.synserver.de
 [212.40.185.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 20D59261A74
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 20:24:25 +0200 (CEST)
In-Reply-To: <20140703161517.GQ2296@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 07/03/2014 06:15 PM, Vinod Koul wrote:
> On Thu, Jul 03, 2014 at 01:18:46PM +0100, Mark Brown wrote:
>>> BUT Now thinking over this again, does this make sense do do with multiple
>>> codecs??
>>
>>> For folks haveing decoders in DSP inside SoC, the compressed device will be
>>> actually a FE. The BE will be PCM to which codec would be linked. The folks
>>> supporting decoders inside codec like WM wont ever need this.
>>
>>> Mark, do you agree to this?
>>
>>> So re-thinking again on why we need this??
>>
>> The use case tends to be for applications that have one device per
>> physical output.  This isn't normally mobile, it's normally high
>> performance audio applications where people are doing things to try to
>> electrically isolate the analogue outputs or dealing with high power so
>> need to keep speaker outputs physically separate.  I can imagine set top
>> box type applications (which do use offloaded media decode) doing this.
>
> Not sure if I follow you, I have no idea of how these systems work.
>
> But if sound card has compressed device it would need to represent using DPCM as
> we don't know the decoder PCM output. The multiple codecs would then connect to
> the PCM BE.
> So on Compressed FE, we wont have multiple codecs.
>
> For codecs, the compressed audio will go to one codec, multiple ones wont make
> sense.
>
> So how can we have a situation where we have compressed device linked to
> multiple codecs?
>

If the assumption is that a DAI link that has a compressed DAI on the CPU side 
is never connected to a 'real' CODEC (or multiple CODECS) on the CODEC side. I 
think we can just leave soc-compress.c alone and just add a sanity check to 
make sure that num_codecs is always 1.

- Lars
