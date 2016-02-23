From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm9713: fix regmap free path
Date: Tue, 23 Feb 2016 14:00:02 +0000
Message-ID: <20160223140002.GE1490@localhost.localdomain>
References: <1456180544-29108-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456180544-29108-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 22, 2016 at 11:35:44PM +0100, Robert Jarzmik wrote:
> In the conversion to regmap, I assumed that the devm_() variant could be
> used in the soc probe function.
> 
> As a mater of fact with the current code the regmap is freed twice
> because of the devm_() call:
> (mutex_lock) from [<c01f6624>] (debugfs_remove_recursive+0x50/0x1d0)
> (debugfs_remove_recursive) from [<c02bf800>] (regmap_debugfs_exit+0x1c/0xd4)
> (regmap_debugfs_exit) from [<c02ba1f8>] (regmap_exit+0x28/0xc8)
> (regmap_exit) from [<c02aa258>] (release_nodes+0x18c/0x204)
> (release_nodes) from [<c02a278c>] (device_release+0x18/0x90)
> (device_release) from [<c0239030>] (kobject_release+0x90/0x1bc)
> (kobject_release) from [<c0395c94>] (wm9713_soc_remove+0x1c/0x24)
> (wm9713_soc_remove) from [<c0384884>] (soc_remove_component+0x50/0x7c)
> (soc_remove_component) from [<c0386c28>] (soc_remove_dai_links+0x118/0x228)
> (soc_remove_dai_links) from [<c038721c>] (snd_soc_register_card+0x4e4/0xdd4)
> (snd_soc_register_card) from [<c0393c54>] (devm_snd_soc_register_card+0x34/0x70)
> 
> Fix this by replacing the devm_regmap initialization code with the non
> devm_() variant.
> 
> Fixes: 700dadfefc3d ASoC: wm9713: convert to regmap
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

I am totally happy for this patch to be merged but would it not
be prefferable to do the regmap init in the device probe and
still use the devm_ call?  Doing the regmap setup in the ASoC
probe is a little unusual and I don't really see any reason why
it is necessary here. Unless I am missing something?

Thanks,
Charles
