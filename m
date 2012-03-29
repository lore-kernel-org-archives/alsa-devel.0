From: gsantosh@codeaurora.org
Subject: ASoC:Question on strict sequence followed for trigger
Date: Wed, 28 Mar 2012 17:25:14 -0700 (PDT)
Message-ID: <1ea6fbaaca7ffeaa7b7325f18fe4e959.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 7440B2448B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 02:25:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I see there is a strict sequence followed for trigger callback to codec
dai, platform dai and cpu dai.
In the below function of soc-core .
int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd);

In some scenarios we may require the sequence to be the other case to make
sure the underlying DSP / codec is configured and triggered properly. I
have a requirement that this sequence has to be
1)        Codec_dai
2)        Cpu_dai
3)        Platform dai

Will this call sequence can be changed or there is no room to change this
sequence.

Regards,
Santosh M G.
