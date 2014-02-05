From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
	parameters from EDID
Date: Wed, 05 Feb 2014 10:19:22 +0100
Message-ID: <52F2021A.9020804@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
	<1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
	<20140204180625.GM22609@sirena.org.uk>
	<20140205101134.4591e5c3@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140205101134.4591e5c3@armhf>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 02/05/2014 10:11 AM, Jean-Francois Moine wrote:
> On Tue, 4 Feb 2014 18:06:25 +0000
> Mark Brown <broonie@kernel.org> wrote:
>
>> On Mon, Jan 27, 2014 at 09:48:54AM +0100, Jean-Francois Moine wrote:
>>
>>> +		/* change the snd_soc_pcm_stream values of the driver */
>>> +		stream->rates = rate_mask;
>>> +		stream->channels_max = max_channels;
>>> +		stream->formats = formats;
>>
>>> +	/* copy the DAI driver to a writable area */
>>> +	dai_drv = devm_kzalloc(&pdev->dev, sizeof(tda998x_dai), GFP_KERNEL);
>>> +	if (!dai_drv)
>>> +		return -ENOMEM;
>>> +	memcpy(dai_drv, tda998x_dai, sizeof(tda998x_dai));
>>> +
>>
>> The code should be doing this by setting constraints based on the
>> current setup rather than by editing the data structure - the expecation
>> is very much that the data won't change so this prevents surprises with
>> future work on the core.
>
> As it is done in the soc core, in soc_pcm_open(), the runtime hw_params
> are initialized after the call to the CODEC startup, and the next CODEC
> event is hw_params() when the user has already chosen all the parameters.
>
> So, in the CODEC, I don't see how I could update the parameters
> dictated by the EDID otherwise in changing the DAI driver parameters.
>

The startup function is the right place. But instead of modifying the DAI 
use snd_pcm_hw_constraint_mask64(), snd_pcm_hw_constraint_list(), etc. to 
setup the additional constraints that come from the EDID.

Bonus points for making this a generic helper function that takes a runtime 
and a EDID and then applies the EDID constraints on the runtime.

- Lars
