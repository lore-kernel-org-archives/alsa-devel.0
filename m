From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ASoC: cs35l35: trivial fix to indentation
Date: Sun, 12 Mar 2017 15:55:28 +0100
Message-ID: <58C56160.9070208@bfs.de>
References: <20170311191922.6209-1-colin.king@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx02-sz.bfs.de (mx02-sz.bfs.de [194.94.69.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E9B3266A10
 for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2017 15:55:33 +0100 (CET)
In-Reply-To: <20170311191922.6209-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Jiri Kosina <trivial@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



Am 11.03.2017 20:19, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Remove extraneous tab to correct the nesting level indentation
> 
> Detected by CoverityScan, CID#1416584 ("Nesting level does
> not match indentation")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/codecs/cs35l35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
> index 260ed42..43d33f4 100644
> --- a/sound/soc/codecs/cs35l35.c
> +++ b/sound/soc/codecs/cs35l35.c
> @@ -1370,7 +1370,8 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
>  
>  	for (i = 0; i < ARRAY_SIZE(cs35l35_supplies); i++)
>  		cs35l35->supplies[i].supply = cs35l35_supplies[i];
> -		cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
> +
> +	cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
>  


I have the feeling is better before the loop:

cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);

for (i = 0; i < cs35l35->num_supplies; i++)
     cs35l35->supplies[i].supply = cs35l35_supplies[i];

re,
 wh

>  	ret = devm_regulator_bulk_get(&i2c_client->dev,
>  			cs35l35->num_supplies,
