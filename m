From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Thu, 08 Aug 2019 14:59:09 +0200
Message-ID: <83988e57c768513425ed79eac6744ed8@agner.ch>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808124437.GD3795@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan.agner@toradex.com>
List-Id: alsa-devel@alsa-project.org

On 2019-08-08 14:44, Mark Brown wrote:
> On Thu, Aug 08, 2019 at 02:36:55PM +0200, Stefan Agner wrote:
>> From: Stefan Agner <stefan.agner@toradex.com>
>>
>> Deferred probes shouldn't cause error messages in the boot log. Avoid
>> printing with dev_err() in case EPROBE_DEFER is the return value.
> 
> No, they absolutely should tell the user why they are deferring so the
> user has some information to go on when they're trying to figure out why
> their device isn't instantiating.

Hm, I see, if the driver defers and does not manage in the end, then the
messages are indeed helpful.

But can we lower severity, e.g. to dev_info? In my case it succeeds in
the end, just defers about 6 times. I have 3 links which then leads to
18 error messages which confuse users... From what I can see
soc_init_dai_link() would print dev_err in case there is an actual
error.

--
Stefan
