From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Why is snd_pcm_hw_params_set_format() not setting the
	format at all?
Date: Mon, 3 Jan 2011 11:03:05 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE03E2D3767B@EDPREX01.logicpd.com>
References: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>
	<alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id AEE0C24381
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 18:03:12 +0100 (CET)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id blEGRzRsQgoi2rOs
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<alsa-devel@alsa-project.org>; Mon, 03 Jan 2011 11:03:07 -0600 (CST)
In-Reply-To: <alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

When I call snd_pcm_hw_params_set_format() to set up a new format, it seems to call following in order and none of them is setting up the format bit?

snd_pcm_hw_params_set_format() -> snd_pcm_hw_param_set() -> _snd_pcm_hw_param_set() -> snd_mask_refine_set() -> snd_mask_single() + snd_mask_leave()

I am using "plughw:0,0" as the device name, and I think it is using pcm_plugin.c for the master and pcm_hw.c for the slave?
If I can use pcm_plug.c, then it should finally call snd_mask_set() from another function snd_pcm_hw_params() with the following call order:

snd_pcm_hw_params -> _snd_pcm_hw_params -> pcm->ops->hw_params() which is snd_pcm_plug_hw_params() -> snd_pcm_plug_hw_refine_schange -> snd_pcm_format_mask_set -> snd_mask_set 

In order to use pcm_plug.c, how do I setup the device name? 

Thanks,
Philip
