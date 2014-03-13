From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFC] ASoC: core: Add support for DAI multicodec
Date: Thu, 13 Mar 2014 12:46:43 +0100
Message-ID: <53219AA3.2060305@baylibre.com>
References: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
 <20140312225125.GZ28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CC0D426519B
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 12:46:45 +0100 (CET)
Received: by mail-we0-f173.google.com with SMTP id w61so727231wes.4
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 04:46:45 -0700 (PDT)
In-Reply-To: <20140312225125.GZ28112@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 12/03/2014 23:51, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 12:17:24PM +0100, Benoit Cousson wrote:
>
>> +struct snd_soc_dai_link_codec {
>> +	const char *codec_name;
>> +	const struct device_node *codec_of_node;
>> +	const char *codec_dai_name;
>> +
>> +	struct snd_soc_codec *codec;
>> +	struct snd_soc_dai *codec_dai;
>> +
>> +	int (*hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
>> +			       struct snd_pcm_hw_params *params);
>> +	struct snd_pcm_hw_params hw_params;
>> +};
>
> The implementation looks basically fine, it's possible there's something
> nasty in there but the patch is rather large and not quite repetitive
> enough.

I think some non-regression tests on that series will be good, because, =

so far it was used on Misa platform (dra7-evm AFAIR) and my own BBB + =

audio cape platform and BBB + 2 mono Codecs from NXP (to be upstreamed =

soon :-)).

We need to ensure that it will not break the thousand ASoC =

implementations we have in mainline today.

> Most of the interface seems good - I'm not super thrilled with
> having the separate CODECs list but equally well the idea of updating
> all the machine drivers isn't super awesome either and should be punted
> for a cleanup run later.

Yes, that's as well the point I don't like, but couldn't find an easy =

and smooth transition solution. And I guess Misa had the same concern =

before.

> I would like to see something nicer for the fixup though - I think we
> can avoid doing it if we use the TDM API to specify the slots that are
> in use by a CODEC.  Xiubo has done some nice work there recently which
> is handy.  Instead of having a fixup function if we specified a TDM
> and channel map configuration then the core core could override the
> params so that the channel count was clamped by how many channels are
> actually being sent to the device - so if there's two TDM slots active
> the device would be told to play stereo.  Would that work for your use
> cases?

Yes, I think so. My current setup is pretty basic: 2 mono Class D =

amplifiers connected to the same I2S link to build a stereo card.

OK, so I'll rebase the patch to asoc/next. I'll try to split the huge =

patch at least into a series of 2 or 3 patches, and I'll remove the =

fixup part.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
