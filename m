From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2 2/3] ASoC: amd: dma driver changes for BT I2S instance
Date: Thu, 19 Apr 2018 00:27:05 +0000
Message-ID: <CAGS+omBzuC75-pbROzwhQ9WqPQpKywZKEYMYGhdjvDNdZu2j=Q@mail.gmail.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com> <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org, Guenter Roeck <linux@roeck-us.net>, kuninori.morimoto.gx@renesas.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Vijendar,

On Wed, Apr 18, 2018 at 5:02 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> With in ACP, There are three I2S controllers can be
> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
> Default enabled I2S controller instance is I2S SP.
> This patch provides required changes to support I2S BT
> controller Instance.

I like the direction this patch is taking, but I think it would be easier
to review if you could split it into 2 parts:
  (1) the cleanup of the existing driver to use a simplified flow for
playback vs capture paths.
  (2) adding the BT I2S channel.


Thanks,
-Dan
