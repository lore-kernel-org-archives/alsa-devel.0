From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 1/2] ASoC: AMD: Fix simultaneous playback
 and capture on different channel
Date: Mon, 10 Sep 2018 22:51:13 +0530
Message-ID: <df52a9e6-457d-754d-ce6e-333752e97ae2@amd.com>
References: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
 <20180910113820.GD5856@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0060.outbound.protection.outlook.com [104.47.32.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 17D2E2676EB
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 19:21:39 +0200 (CEST)
In-Reply-To: <20180910113820.GD5856@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On 9/10/2018 5:08 PM, Mark Brown wrote:
> On Mon, Sep 10, 2018 at 01:36:29PM +0530, Akshu Agrawal wrote:
>> If capture and playback are started on different channel (I2S/BT)
>> there is a possibilty that channel information passed from machine driver
>> is overwritten before the configuration is done in dma driver.
>> Example:
>> 113.597588: cz_max_startup: ---playback sets BT channel
>> 113.597694: cz_dmic1_startup: ---capture sets I2S channel
>> 113.597979: acp_dma_hw_params: ---configures capture for I2S channel
>> 113.598114: acp_dma_hw_params: ---configures playback for I2S channel
>>
>> This is fixed by having lock between startup and prepare. This ensures
>> no other codec startup gets called between a codec's startup(where channel
>> info is set) and hw_params(where channel info is read).
> 
> This isn't viable - the driver will deadlock if the application hits an
> error and never gets to startup, or if the application tries to
> simultaneously configure two channels (ie, do all the prepares and then
> all the parameter configuration and then startup).

We can avoid deadlock by having another mutex_unlock in the shutdown
call of each of codec's ops. Wouldn't in all possible termination
scenarios, it will cleanup and exit via shutdown callback?

Having said that I think there is a better approach to this, is by
having 2 separate instance variable for playback and capture for passing
instance info from machine driver to dma driver. Respective codec in
machine driver will set the capture/playback instance. dma driver on the
basis of substream->stream can read the correct one. No fear of deadlock
in this.

Thanks,
Akshu
