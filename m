From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] ASoC: core: Fix return code shown on error for hw_params
Date: Wed, 30 May 2018 16:16:31 +0100
Message-ID: <cecd3b0d-b4b4-9b22-13be-3f6c51264cfe@nvidia.com>
References: <1527693178-5038-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527693178-5038-1-git-send-email-jonathanh@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 30/05/18 16:12, Jon Hunter wrote:
> The call to hw_params for a component fails the error code is held by
> the variable '__ret' but the error message displays the value held by
> the variable 'ret'. Fix the return code shown when hw_params fails for
> a component.

Sorry, just resent this as I realise the description does not read correctly!

Jon

-- 
nvpublic
