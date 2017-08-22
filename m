From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 1/9] ASoC: rt5514: Avoid legacy dai
	naming
Date: Tue, 22 Aug 2017 12:20:20 +0800
Message-ID: <599BB104.4020600@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
 <20170818031147.16810-2-jeffy.chen@rock-chips.com>
 <20170818114544.szfxl5pbul7gwgxg@sirena.org.uk>
 <599701D2.5080001@rock-chips.com>
 <20170821173107.wzkbnvqylkovg634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 34D3B266D86
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 06:20:36 +0200 (CEST)
In-Reply-To: <20170821173107.wzkbnvqylkovg634@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

thanks for your reply.

On 08/22/2017 01:31 AM, Mark Brown wrote:
> On Fri, Aug 18, 2017 at 11:03:46PM +0800, jeffy wrote:
>
>> when using legacy dai naming, the dai->name for rt5514-spi would be the dev
>> name, which is spi2.0 with my local 4.4 kernel, and would be spi32765.0 with
>> upstream kernel.
>
> It would be better to fix the code to not need a name if the device by
> itself is unambiguous.
>

right...

i'm not familiar with the soc core codes, would these make sense?

1/ consider match when the of nodes are the same:

@@ -978,9 +978,10 @@ struct snd_soc_dai *snd_soc_find_dai(
                 if (dlc->name && strcmp(component->name, dlc->name))
                         continue;
                 list_for_each_entry(dai, &component->dai_list, list) {
+                       if (dlc->of_node && dai->dev->of_node == 
dlc->of_node)
+                               return dai;

or
2/ return the first dai when there's only one:

@@ -977,10 +977,11 @@ struct snd_soc_dai *snd_soc_find_dai(
                         continue;
                 if (dlc->name && strcmp(component->name, dlc->name))
                         continue;
+               if (component->num_dai == 1)
+                       return &component->dai_list[0];
                 list_for_each_entry(dai, &component->dai_list, list) {

or
3/ also check for dai driver name:

@@ -978,9 +978,10 @@ struct snd_soc_dai *snd_soc_find_dai(
                 if (dlc->name && strcmp(component->name, dlc->name))
                         continue;
                 list_for_each_entry(dai, &component->dai_list, list) {
-                       if (dlc->dai_name && strcmp(dai->name, 
dlc->dai_name))
+                       if (dlc->dai_name && strcmp(dai->name, 
dlc->dai_name)
+                           && strcmp(dai->driver->name, dlc->dai_name))
                                 continue;
