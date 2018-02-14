From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: wm9713: Use empty struct
 initializer
Date: Wed, 14 Feb 2018 16:41:18 +0000
Message-ID: <938aa54c-c599-9efc-e78f-4e72db08199e@opensource.cirrus.com>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
 <1518622745-12162-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E36A8266F0D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 17:41:21 +0100 (CET)
In-Reply-To: <1518622745-12162-2-git-send-email-festevam@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On 14/02/18 15:39, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> { 0 } only clears the first member of the structure.
> 

Not according to the C99 and C11 standards.
C11 6.7.9.21 (C99 has the same statement):

   If there are fewer initializers in a brace-enclosed list than
   there are elements or members of an aggregate, or fewer characters
   in a string literal used to initialize an array of known size than
   there  are  elements in the array, the remainder of the aggregate
   shall be initialized implicitly the same as objects that have static
   storage duration.

C11 6.7.9.10 defines that "objects that have static storage duration"
shall be initialized to zero.

So according to both C11 and C99 standards {0} should (and must) 
initialize the entire structure to zero.

> The first member of the snd_soc_dapm_update struct is a pointer,
> and writing 0 to a pointer results in a sparse warning.
> 

This is the actual problem you are trying to fix? The comment about
{ 0 } only clearing the first member is probably bogus, your actual
problem is that it should have been { NULL } ?

So the fix works (because of 6.7.9.21 quoted above) but the commit 
message is incorrect/misleading about what the problem is and why
this is a fix for it.

> Use the empty struct initializer that clears all the struct members
> and fixes the sparse warning.
> 
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>   sound/soc/codecs/wm9713.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
> index 3d6cf00..643863b 100644
> --- a/sound/soc/codecs/wm9713.c
> +++ b/sound/soc/codecs/wm9713.c
> @@ -235,7 +235,7 @@ static int wm9713_hp_mixer_put(struct snd_kcontrol *kcontrol,
>   	struct soc_mixer_control *mc =
>   		(struct soc_mixer_control *)kcontrol->private_value;
>   	unsigned int mixer, mask, shift, old;
> -	struct snd_soc_dapm_update update = { 0 };
> +	struct snd_soc_dapm_update update = {};
>   	bool change;
>   
>   	mixer = mc->shift >> 8;
> 
