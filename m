From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: topology: avoid uninitialized kcontrol_type
Date: Sun, 11 Dec 2016 00:45:02 +0900
Message-ID: <20fcf0c4-260f-7cfd-98b0-07045722efc8@sakamocchi.jp>
References: <20161209115207.3885433-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209115207.3885433-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Arnd,

On Dec 9 2016 20:51, Arnd Bergmann wrote:
> When num_kcontrols is zero, widget->dobj.widget.kcontrol_type
> gets set to an uninitialized local variable:
>
> sound/soc/soc-topology.c: In function 'soc_tplg_dapm_widget_create':
> sound/soc/soc-topology.c:1566:36: error: 'kcontrol_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> I could not figure out which of the valid types would be appropriate
> here, so this sets it to '0', which is invalid but at least well-defined
> here. There is probably a better way to address the issue.
>
> Fixes: eea3dd4f1247 ("ASoC: topology: Only free TLV for volume mixers of a widget")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/soc-topology.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 11feb19e9730..65670b2b408c 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1485,6 +1485,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
>  	tplg->pos +=
>  		(sizeof(struct snd_soc_tplg_dapm_widget) + w->priv.size);
>  	if (w->num_kcontrols == 0) {
> +		kcontrol_type = 0;
>  		template.num_kcontrols = 0;
>  		goto widget;
>  	}

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

This bug was already reported but not fixed yet:
[alsa-devel] [bug report] ASoC: topology: Only free TLV for volume 
mixers of a widget
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-December/115577.html

As you said, this solution looks band-aid, however we have no 
alternatives to fix the warning...


Regards

Takashi Sakamoto
