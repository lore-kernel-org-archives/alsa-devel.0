From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/7] ASoC: fix debugfs directory creation
 bug
Date: Fri, 27 Jun 2014 04:45:11 +0200
Message-ID: <53ACDAB7.5080703@metafoo.de>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
 <E1X0AZe-0003i7-0z@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-198.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E240261ADC
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 04:45:27 +0200 (CEST)
In-Reply-To: <E1X0AZe-0003i7-0z@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 06/26/2014 04:22 PM, Russell King wrote:
> Avoid creating duplicate directories by prefixing codecs and platforms
> with their separate identifiers.  This avoids snd-soc-dummy (which can
> appear both as a dummy platform and a dummy codec on the same card)
> from clashing.

Do we actually want to create debugfs entries for the snd-soc-dummies? There 
shouldn't be any meaningful information in there.

If we want to and if we change the naming scheme of the debugfs entries 
anyway we should also add the component name to the entry name. This fixes a 
issue with devices that register multiple components.

The other thing is that we are working on generalizing the ASoC code and 
getting rid of the distinction between CODECs and platforms. Which means 
there won't really a way to get the prefix anymore soon.

- Lars

>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   sound/soc/soc-core.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b87d7d882e6d..91120b8e283e 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -270,12 +270,32 @@ static const struct file_operations codec_reg_fops = {
>   	.llseek = default_llseek,
>   };
>
> +static struct dentry *soc_debugfs_create_dir(struct dentry *parent,
> +	const char *fmt, ...)
> +{
> +	struct dentry *de;
> +	va_list ap;
> +	char *s;
> +
> +	va_start(ap, fmt);
> +	s = kvasprintf(GFP_KERNEL, fmt, ap);
> +	va_end(ap);
> +
> +	if (!s)
> +		return NULL;
> +
> +	de = debugfs_create_dir(s, parent);
> +	kfree(s);
> +
> +	return de;
> +}
> +
>   static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
>   {
>   	struct dentry *debugfs_card_root = codec->card->debugfs_card_root;
>
> -	codec->debugfs_codec_root = debugfs_create_dir(codec->name,
> -						       debugfs_card_root);
> +	codec->debugfs_codec_root = soc_debugfs_create_dir(debugfs_card_root,
> +						"codec:%s", codec->name);
>   	if (!codec->debugfs_codec_root) {
>   		dev_warn(codec->dev,
>   			"ASoC: Failed to create codec debugfs directory\n");
> @@ -306,8 +326,8 @@ static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
>   {
>   	struct dentry *debugfs_card_root = platform->card->debugfs_card_root;
>
> -	platform->debugfs_platform_root = debugfs_create_dir(platform->name,
> -						       debugfs_card_root);
> +	platform->debugfs_platform_root = soc_debugfs_create_dir(debugfs_card_root,
> +						"platform:%s", platform->name);
>   	if (!platform->debugfs_platform_root) {
>   		dev_warn(platform->dev,
>   			"ASoC: Failed to create platform debugfs directory\n");
>
