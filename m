From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 1/1] ASoC: rsnd: ssi: Fix issue in dma
 data address assignment
Date: Wed, 20 Dec 2017 23:13:02 -0800
Message-ID: <5A3B5EFE.8070606@mentor.com>
References: <1513832314-29727-1-git-send-email-jiada_wang@mentor.com>
 <87k1xgbnfz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 96BA7266DB1
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 08:13:07 +0100 (CET)
In-Reply-To: <87k1xgbnfz.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

On 12/20/2017 10:42 PM, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> Same SSI device may be used in different dai links,
>> by only having one dma struct in rsnd_ssi, after the first
>> instance's dma config be initilized, the following instances
>> can no longer configure dma, this causes issue, when their
>> dma data address are different from the first instance.
>>
>> This patch by introduces two dma struct in rdai, each SSI
>> instance in a dai link is assigned with two dma struct,
>> to store dma configuration for playback and capture.
>>
>> Signed-off-by: Jiada Wang<jiada_wang@mentor.com>
>> ---
> (snip)
>> @@ -876,7 +876,7 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
>>   		return ret;
>>
>>   	/* SSI probe might be called many times in MUX multi path */
>> -	ret = rsnd_dma_attach(io, mod,&ssi->dma);
>> +	ret = rsnd_dma_attach(io, mod,&rdai->dma[is_play]);
>>
>>   	return ret;
>>   }
> Some cases, same SSI might be used on different dai links.
> In my understanding, it happen if you uses MIXer.
> But, are you using same SSI for both playback and capture ??
No, I am not using same SSI in both playback and capture of same dai-link,
without this patch, I am seeing issues when rcar sound is working in 
multi DAI mode,
for example with the following configuration

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi 
b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index a298df7..16f3214 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -94,14 +94,24 @@
         };

         rsnd_ak4613: sound {
-               compatible = "simple-audio-card";
+               compatible = "simple-scu-audio-card";

                 simple-audio-card,format = "left_j";
                 simple-audio-card,bitclock-master = <&sndcpu>;
                 simple-audio-card,frame-master = <&sndcpu>;

-               sndcpu: simple-audio-card,cpu {
-                       sound-dai = <&rcar_sound>;
+               simple-audio-card,prefix = "ak4613";
+                simple-audio-card,routing =
+                        "ak4613 Playback", "DAI0 Playback",
+                        "DAI0 Capture", "ak4613 Capture",
+                        "ak4613 Playback", "DAI1 Playback";
+
+               sndcpu: simple-audio-card,cpu@0 {
+                       sound-dai = <&rcar_sound 0>;
+               };
+
+               simple-audio-card,cpu@1 {
+                       sound-dai = <&rcar_sound 1>;
                 };

                 sndcodec: simple-audio-card,codec {
@@ -517,7 +527,7 @@
         pinctrl-names = "default";

         /* Single DAI */
-       #sound-dai-cells = <0>;
+       #sound-dai-cells = <1>;

         /* audio_clkout0/1/2/3 */
  #clock-cells = <1>;
@@ -549,6 +559,9 @@
                         playback = <&ssi0 &src0 &dvc0>;
                         capture  = <&ssi1 &src1 &dvc1>;
                 };
+               dai1 {
+                       playback = <&ssi0>;
+               };
         };
  };

playing with dai1 will have issue.

Thanks,
Jiada

> Best regards
> ---
> Kuninori Morimoto
