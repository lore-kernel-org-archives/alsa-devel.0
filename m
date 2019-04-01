From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: regression: bad sound card type detection in audio
	graph
Date: Mon, 1 Apr 2019 15:53:07 +0200
Message-ID: <03f247d6-6a41-7e92-3b5f-33a94d59c8bb@st.com>
References: <17699625-dd15-afc7-780f-c7c2d4721525@st.com>
 <87pnqbrfqg.wl-kuninori.morimoto.gx@renesas.com>
 <ca008e8f-a031-d78d-2ee6-55f90a39378b@st.com>
 <87muleo3dd.wl-kuninori.morimoto.gx@renesas.com>
 <3011cbc1-0142-009f-ff96-66f330b4fc77@st.com>
 <87d0m6inv2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31D12F8075C
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 15:53:11 +0200 (CEST)
In-Reply-To: <87d0m6inv2.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Olivier MOYSAN <olivier.moysan@st.com>, "tiwai@suse.com" <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

On 4/1/19 2:26 AM, Kuninori Morimoto wrote:
> 
> Hi Arnaud
> 
>> > Easy solution I noticed now is that compatible = "audio-graph-card" case
>> > should only select non DPCM case, same as before.
>> > compatible = "audio-graph-scu-card" can be both "non DPCM" and "DPCM".
>> > I think only user of "audio-graph-scu-card" is me, and it is local use.
>> > I think it is still DT backward compatible (?)
>> > I didn't test this patch, but maybe similar can be solution ?
>> 
>> Yes i think that is a good proposal with advantage of ensuring
>> compatibility with existing code.
>> 
>> Thanks for your clarifications!
> 
> Good !
> Can you test and post patch ?
> I think my proposed patch is not good enough for you (?).
> I want to test your tested patch on my side.

I tested the patch you proposed it works perfectly.
For your information , we have posted in parallel a patch to support
multi endpoint for the cs42l51 codec.
https://www.spinics.net/lists/alsa-devel/msg88655.html
This patch as been accepted by Marc and should be part on the next pull
request.
Associated DT (need to be upstreamed) is visible
here:https://github.com/STMicroelectronics/linux/blob/196201973b7048ccf75aa63ac3c3673f8b6ee1c1/arch/arm/boot/dts/stm32mp157a-dk1.dts#L212

For sure I can propose the patch in audio graph but it is your idea,
and i have no major update/fix on it. So if you prefer you can post it
and i will ack it.

@ -20,10 +20,12 @@
 #include <linux/string.h>
 #include <sound/simple_card_utils.h>

 #define PREFIX	"audio-graph-card,"

+#define DPCM_SELECTABLE 1
+
 static int graph_outdrv_event(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol,
 			      int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
@@ -414,10 +416,12 @@ static int graph_for_each_link(struct
asoc_simple_priv *priv,
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old = NULL;
 	struct asoc_simple_data adata;
 	int rc, ret;
+	unsigned int dpcm_selectable =
+				   (unsigned int)of_device_get_match_data(dev);

 	/* loop for all listed CPU port */
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		cpu_port = it.node;
 		cpu_ep	 = NULL;
@@ -443,12 +447,13 @@ static int graph_for_each_link(struct
asoc_simple_priv *priv,
 			/*
 			 * It is DPCM
 			 * if Codec port has many endpoints,
 			 * or has convert-xxx property
 			 */
-			if ((of_get_child_count(codec_port) > 1) ||
-			    adata.convert_rate || adata.convert_channels)
+			if (dpcm_selectable  &&
+			    ((of_get_child_count(codec_port) > 1) ||
+			    adata.convert_rate || adata.convert_channels))
 				ret = func_dpcm(priv, cpu_ep, codec_ep, li,
 						(codec_port_old == codec_port));
 			/* else normal sound */
 			else
 				ret = func_noml(priv, cpu_ep, codec_ep, li);
@@ -677,11 +682,13 @@ static int graph_remove(struct platform_device *pdev)
 	return asoc_simple_clean_reference(card);
 }

 static const struct of_device_id graph_of_match[] = {
 	{ .compatible = "audio-graph-card", },
-	{ .compatible = "audio-graph-scu-card", },
+	{ .compatible = "audio-graph-scu-card",
+	  .data = (void *)DPCM_SELECTABLE
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, graph_of_match);

 static struct platform_driver graph_card = {



Thanks,
Arnaud

> 
> Best regards
> ---
> Kuninori Morimoto
