From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH/RFC 11/14] ASoC: samsung: odroidx2: Handle I2S CDCLK clock
 conditionally
Date: Wed, 17 Dec 2014 16:18:38 +0100
Message-ID: <54919ECE.7040404@samsung.com>
References: <1418319952-10163-1-git-send-email-s.nawrocki@samsung.com>
 <1418319952-10163-12-git-send-email-s.nawrocki@samsung.com>
 <20141212185332.GS11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141212185332.GS11764@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, padma.v@samsung.com, drake@endlessm.com, sbkim73@samsung.com
List-Id: alsa-devel@alsa-project.org

On 12/12/14 19:53, Mark Brown wrote:
> On Thu, Dec 11, 2014 at 06:45:49PM +0100, Sylwester Nawrocki wrote:
>> > If the codec control it's master clock provider by the I2S module
>> > we should not be touching it with set_sysclk() calls.
>> > So skip the set_sysclk() call in the machine driver if "clocks"
>> > property is found in the codec device node.
>
> Please clarify in the changelog here that this is a transition measure
> to support old DTs, it's not clear why we might want to do things for
> the I2S controller by fishing around in the CODEC DT otherwise.

Indeed, there is some room for improvement. I'll add such note to the
commit description. Presumably this whole driver could be removed
after a kernel release or two, since we switched Odroid X2/U3 to
the simple-card.

-- 
Regards,
Sylwester
