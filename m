From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 4/7] Asoc: sti: add CPU DAI driver for
	capture
Date: Mon, 27 Apr 2015 16:53:24 +0200
Message-ID: <553E4D64.8060803@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-5-git-send-email-arnaud.pouliquen@st.com>
 <20150424182011.GH22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AD84D2605C8
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 16:53:27 +0200 (CEST)
In-Reply-To: <20150424182011.GH22845@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 04/24/2015 08:20 PM, Mark Brown wrote:
> On Tue, Apr 14, 2015 at 03:35:28PM +0200, Arnaud Pouliquen wrote:
>
>> +const struct snd_pcm_hardware uni_reader_pcm_hw = {
>> +	.info = (SNDRV_PCM_INFO_INTERLEAVED |
>> +		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> +		 SNDRV_PCM_INFO_PAUSE),
> The commit message says this is a CPU DAI but a snd_pcm_hardware is a
> DMA controller.
Do you means that i should just define a structure related to DAI 
constraints
and fill snd_pcm_hardware in sti_platform.c?
>
>> +static inline int get_property_hdl(struct device *dev, struct device_node *np,
>> +				   const char *prop, int idx)
> This appears to be duplicated from the previous patch, as does a *lot*
> of the code here.  Can we not share more of the code between playback
> and capture paths?
I spitted reader and player code,because it is 2 different IPs with some 
specific features and behavior
( clock, master/slave mode, IEC, standby ...).
 From my point of view is is more clear like this, but It is feasible to 
merge both code
adding conditions on direction in most functions. Please tell me what 
you prefer.
I case of merge i suppose that the best is to not define uniperif_ops 
struct but externalize functions...
