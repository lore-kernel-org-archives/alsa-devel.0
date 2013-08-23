From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3] ASoC: rt5640: change widget sequence
 for depop
Date: Fri, 23 Aug 2013 10:26:51 -0600
Message-ID: <52178D4B.1040101@wwwdotorg.org>
References: <1377224966-27426-1-git-send-email-bardliao@realtek.com>
 <52178970.2080406@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B3E9C2610AB
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 18:26:56 +0200 (CEST)
In-Reply-To: <52178970.2080406@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 08/23/2013 10:10 AM, Stephen Warren wrote:
> On 08/22/2013 08:29 PM, bardliao@realtek.com wrote:
>> From: Bard Liao <bardliao@realtek.com>
> 
> A patch description might be useful?
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>

Oh, but remember that this patch depends on the following from
Lars-Peter that hasn't yet been posted, so this patch shouldn't be
applied until that one is, or it'll break things horribly:

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d84bd0f..2ed1dcd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -229,6 +229,8 @@ static int dapm_kcontrol_data_alloc(struct
snd_soc_dapm_widget *widget,
                        template.id = snd_soc_dapm_kcontrol;
                        template.name = kcontrol->id.name;

+                       data->value = template.on_val;
+
                        data->widget =
snd_soc_dapm_new_control(widget->dapm,
                                &template);
                        if (!data->widget) {
