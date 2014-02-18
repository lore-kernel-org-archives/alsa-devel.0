From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/17 v2] ASoC: dapm: Add unlocked version of snd_soc_dapm_sync
Date: Tue, 18 Feb 2014 17:14:27 +0100
Message-ID: <530386E3.2030405@metafoo.de>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com> <1392736948-26623-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392736948-26623-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On 02/18/2014 04:22 PM, Charles Keepax wrote:
> We will often call sync after several functions that require the DAPM
> mutex to be held. Rather than release and immediately relock the mutex
> provide an unlocked function for this situation.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

We should add lockdep_assert() to the unlocked versions to catch broken 
users, but that can be done in a follow-up patch.
