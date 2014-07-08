From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH V3 2/2] ASoC: samsung: Add machine driver for Odroid X2/U3
Date: Tue, 8 Jul 2014 10:15:22 +0100
Message-ID: <CAD8Lp44JFtbcD22c+0PVb5S4U1kVTTxHD=PgqiKzhVypFW5Prg@mail.gmail.com>
References: <1404479625-25385-1-git-send-email-s.nawrocki@samsung.com>
	<1404479625-25385-2-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1404479625-25385-2-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Chen Zhen <zhen1.chen@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Sylwester,

On Fri, Jul 4, 2014 at 2:13 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This patch adds the sound subsystem driver for Odroid-X2 and
> Odroid-U3 boards. The codec works in I2S master mode; there
> are two separate audio routing paths defined, as there are
> differences in the signal routing between the X2 and U3 boards,
> i.e. U3 uses single jack for headphones and microphone.
>
> Signed-off-by: Chen Zhen <zhen1.chen@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Testing on ODROID-U2, v3 is not quite working for me, but v2 of the
patch was fine.
I boot up, run:
# speaker-test -c 2 -t wav

As soon as I hear the word "front" I press ctrl+c and then run the
command again.
Now the command hangs with no audible output.

Any ideas? Let me know if you have trouble reproducing.

Thanks
Daniel
