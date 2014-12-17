From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH/RFC 04/14] ASoC: samsung: i2s: Request memory region in
 driver probe()
Date: Wed, 17 Dec 2014 16:10:32 +0100
Message-ID: <54919CE8.1070800@samsung.com>
References: <1418319952-10163-1-git-send-email-s.nawrocki@samsung.com>
 <1418319952-10163-5-git-send-email-s.nawrocki@samsung.com>
 <20141212184927.GR11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141212184927.GR11764@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, padma.v@samsung.com, drake@endlessm.com, sbkim73@samsung.com
List-Id: alsa-devel@alsa-project.org

On 12/12/14 19:49, Mark Brown wrote:
> On Thu, Dec 11, 2014 at 06:45:42PM +0100, Sylwester Nawrocki wrote:
>> > The memory mapped registers region is common for both DAIs so request
>> > it in the I2S platform device driver's probe for the platform device
>> > corresponding to the primary DAI, rather than in the ASoC DAI's probe
>> > callback. While at it switch to devm_ioremap_resource(). This also
>> > drops the hard coded (0x100) register region size in the driver.
>
> This doesn't apply against current code, please check and resend.

It seems I've used your topic/samsung branch as a base. Let me rebase
to the for-next branch and resend.

-- 
Regards,
Sylwester
