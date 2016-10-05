From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: core: allow control index different
	from 0
Date: Wed, 5 Oct 2016 15:59:00 +0900
Message-ID: <57F4A4B4.5070400@sakamocchi.jp>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 49F5C265284
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 08:59:07 +0200 (CEST)
In-Reply-To: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Moise Gergaud <moise.gergaud@st.com>, broonie@kernel.org, kernel@stlinux.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 5 2016 00:36, Arnaud Pouliquen wrote:
> To differentiate control with same name only device field can be used.
> But some applications like iecset use control index to differentiate
> controls linked to several PCM devices or DAIs.
> This patch suppress index overwriting to allow to use control index field.

An control element can be identified by two ways from user land:
 - A combination of name/index/interface/device/subdevice
 - A numerical identification number (numid)

In kernel land, some control elements can be managed as one control
element set, mainly due to saving memory usage. The index represents
offset of an element in the element set.

If your patch is applied, callers of snd_soc_cnew() in kernel land can
assign arbitrary index number to an element set, as the offset of the
first element.

According to current implementation, all of first element in element
sets had index number zero; e.g.
$ amixer controls
...
numid=52,iface=MIXER,name='byte-element-26'
numid=53,iface=MIXER,name='byte-element-26',index=1
numid=54,iface=MIXER,name='byte-element-26',index=2
numid=55,iface=MIXER,name='byte-element-26',index=3
numid=56,iface=MIXER,name='byte-element-26',index=4
...

On the other hand, after applying your patch, some element set with
index larger than zero can exist; e.g.
$ amixer controls
...
numid=52,iface=MIXER,name='byte-element-26',index=10
numid=53,iface=MIXER,name='byte-element-26',index=11
numid=54,iface=MIXER,name='byte-element-26',index=12
numid=55,iface=MIXER,name='byte-element-26',index=13
numid=56,iface=MIXER,name='byte-element-26',index=14
(here, I assign 10 as index to this element set)
(no other elements with name of 'byte-element-26')
...

In this case, elements with index 0-9 don't exist. This case is a bit
confusing to application developers, I think.

I can guess that developers for ALSA SoC part would like to avoid the
missing elements with index 0-9, by force to start indexing at zero.

So, if you'd like to start elements with index non-zero, it's better to
describe your case to get advantages from this patch.

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  sound/soc/soc-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 4afa8db..39bc1a9 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2175,7 +2175,6 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
>  	char *name = NULL;
>  
>  	memcpy(&template, _template, sizeof(template));
> -	template.index = 0;
>  
>  	if (!long_name)
>  		long_name = template.name;

Regards

Takashi Sakamoto
