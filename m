From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Fix logical-not-parentheses warning
Date: Sun, 02 Aug 2015 07:16:25 -0700
Message-ID: <1438524985.1301.26.camel@perches.com>
References: <s5hzj2ab1ye.wl-tiwai@suse.de>
 <1438506537-26743-1-git-send-email-barletz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0051.hostedemail.com
 [216.40.44.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3DABF2604DA
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 16:16:30 +0200 (CEST)
In-Reply-To: <1438506537-26743-1-git-send-email-barletz@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomer Barletz <barletz@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, clemens@ladisch.de, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Sun, 2015-08-02 at 02:08 -0700, Tomer Barletz wrote:
> This fixes the following warning, that is seen with gcc 5.1:
> warning: logical not is only applied to the left hand side of 
> comparison [-Wlogical-not-parentheses].
[]
> diff --git a/sound/pci/oxygen/oxygen_mixer.c 
[]
> 
@@ -88,7 +88,7 @@ static int dac_mute_put(struct snd_kcontrol *ctl,
>       int changed;
>  
>       mutex_lock(&chip->mutex);
> -     changed = !value->value.integer.value[0] != chip->dac_mute;
> +     changed = (!value->value.integer.value[0]) != chip->dac_mute;

It seems this is because dac_mute's value is inverted
0 means true, 1 is false.

I think it'd be simpler if dac_mute was converted to a
standard bool (or perhaps renamed to not_muted) and
this test was rewritten.

Using !!value->value.integer.value[0] would also be
more readable and intelligible.
