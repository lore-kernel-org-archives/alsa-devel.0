From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 2/3] ASoC: atmel_ssc_dai: refactor the startup and shutdown
Date: Mon, 9 Feb 2015 08:52:52 +0800
Message-ID: <54D804E4.1000202@atmel.com>
References: <1422610724-7222-1-git-send-email-voice.shen@atmel.com> <1422610724-7222-3-git-send-email-voice.shen@atmel.com> <20150130132047.GO26617@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20150130132047.GO26617@finisterre.sirena.org.uk>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: nicolas.ferre@atmel.com, Songjun.Wu@atmel.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 01/30/2015 09:20 PM, Mark Brown wrote:
> On Fri, Jan 30, 2015 at 05:38:43PM +0800, Bo Shen wrote:
>> In startup function, enable ssc clock and in shutdown function,
>> disable clock. And also remove disable ssc in shutdown function,
>> as ssc is disabled in prepare function.
>
> Applied, thanks.  You probably want to convert to clk_prepare_enable()
> too but that's a separate thing.

OK, thanks, I will check that. As now, we prepare clock in ssc driver, 
then enable it in dai driver.

Best Regards,
Bo Shen

