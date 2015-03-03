From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: Add a NULL pointer check
 in asoc_simple_card_dai_link_of
Date: Tue, 03 Mar 2015 14:18:50 +0100
Message-ID: <54F5B4BA.7090408@metafoo.de>
References: <CAC3a_SBrJxS6x+qCwi0p5DcbEbVFX3AOP=-NxWbugY6bEvirLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAC3a_SBrJxS6x+qCwi0p5DcbEbVFX3AOP=-NxWbugY6bEvirLg@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: vishal.thanki@gmail.com, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/03/2015 02:14 PM, Vishal Thanki wrote:
[...]
> + if (!name) {
> + ret = -ENOMEM;
> + goto dai_link_of_err;
> + }
> +

The indention here is broken.

