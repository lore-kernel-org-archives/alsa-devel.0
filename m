From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: wm9713: fix regmap free path
Date: Sun, 21 Feb 2016 11:12:51 +0100
Message-ID: <56C98DA3.4000701@metafoo.de>
References: <1455997470-12307-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-176.synserver.de
 [212.40.185.176])
 by alsa0.perex.cz (Postfix) with ESMTP id CC4C4260647
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 17:02:32 +0100 (CET)
In-Reply-To: <1455997470-12307-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/20/2016 08:44 PM, Robert Jarzmik wrote:
> In the conversion to regmap, I assumed that the 2 following functions
> was working symetrically:
>  - snd_soc_codec_init_regmap()
>  - snd_soc_codec_exit_regmap(codec)
> 
> As a mater of fact with the current code the regmap is freed twice
> because of the devm_() call:
> (mutex_lock) from (debugfs_remove_recursive+0x50/0x1d0)
> (debugfs_remove_recursive) from (regmap_debugfs_exit+0x1c/0xd4)
> (regmap_debugfs_exit) from (regmap_exit+0x28/0xc8)
> (regmap_exit) from (release_nodes+0x18c/0x204)
> (release_nodes) from (device_release+0x18/0x90)
> (device_release) from (kobject_release+0x90/0x1bc)
> (kobject_release) from (wm9713_soc_remove+0x1c/0x24)
> (wm9713_soc_remove) from (soc_remove_component+0x50/0x7c)
> (soc_remove_component) from (soc_remove_dai_links+0x118/0x228)
> (soc_remove_dai_links) from (snd_soc_register_card+0x4e4/0xdd4)
> (snd_soc_register_card) from (devm_snd_soc_register_card+0x34/0x70)
> 
> Fix this by removing the doubled regmap free.

The correct fix is to use the non devm variant of regmap_init_ac97() in this
case. Device managed functions should only be used from inside a struct
device probe function.

- Lars
