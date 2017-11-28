From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 0/2] Update codec driver for dual mics configuration
Date: Tue, 28 Nov 2017 14:08:05 +0000
Message-ID: <CAOQ7t2Z=gyX5jyewnM_1gD6_Vnsrs2v6GGToyEkd7tSTHc7FQg@mail.gmail.com>
References: <20171121171546.5656-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121171546.5656-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux Upstreaming Team <linux@endlessm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, open list <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 21, 2017 at 5:15 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> The RT5651 codec has 3 analog input ports. Some laptops (like the KIANO laptop)
> have two different analog mics on two ports, leaving the headset on the
> remaining one. We need to add a new quirk to support also this configuration.
>
> Carlo Caione (2):
>   ASoC: intel: byt: Introduce new map for dual mics
>   ASoC: intel: byt: Fix quirk for KIANO laptop

gentle ping.

cheers,

-- 
Carlo Caione
