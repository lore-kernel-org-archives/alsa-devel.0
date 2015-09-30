From: Ben Zhang <benzh@chromium.org>
Subject: Re: [PATCH] ASoC: rt5645: Allow 4 channel recording on
	AIF1
Date: Wed, 30 Sep 2015 15:14:19 -0700
Message-ID: <CAOV7By+5D5=s=tryYXJxDKk=7d1sNKBwcA+1TXe-pa5G1Z9OPQ@mail.gmail.com>
References: <1443472357-12150-1-git-send-email-benzh@chromium.org>
 <20150930190308.GY15635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B738D26644E
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 00:14:21 +0200 (CEST)
Received: by igcrk20 with SMTP id rk20so1982397igc.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 15:14:19 -0700 (PDT)
In-Reply-To: <20150930190308.GY15635@sirena.org.uk>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel <alsa-devel@alsa-project.org>, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 30, 2015 at 12:03 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 28, 2015 at 01:32:37PM -0700, Ben Zhang wrote:
>> The codec supports 4 channel recording with TDM on AIF1.
>> This patch modifies the DAI capability to allow it.
>
> Is there no code change needed to configure for the number of channels
> being used?  I can't see any current handling of that, nor anything that
> looks like non-stereo handling in the DAPM graph.

No code change is needed. The current driver already supports 4
channel recording from DMICs using the Stereo1 path and the two Mono
paths. rt5645_set_tdm_slot callback handles the I2S1 port config for
TDM. It has been tested on a broadwell chromebook. An ASoC machine
driver just needs to call snd_soc_dai_set_tdm_slot, and let ucm config
file set the muxes/mixers for the following paths.

"DMIC L1"/"DMIC R1"
-> "DMIC1"
-> "Stereo1 DMIC Mux"
-> "Stereo1 ADC L2 Mux"/"Stereo1 ADC R2 Mux"
-> "Sto1 ADC MIXL"/"Sto1 ADC MIXR"
-> "Stereo1 ADC MIXL"/"Stereo1 ADC MIXR"
-> "IF_ADC1"
-> "RT5650 IF1 ADC1 Swap Mux"
-> "IF1 ADC"
-> "RT5650 IF1 ADC Mux"
-> "AIF1TX"
-> "AIF1 Capture"

"DMIC L2"
-> "Mono DMIC L Mux"
-> "Mono ADC L2 Mux"
-> "Mono ADC MIXL"
-> "IF_ADC2"
-> "RT5650 IF1 ADC2 Swap Mux"
-> "IF1 ADC"
-> "RT5650 IF1 ADC Mux"
-> "AIF1TX"
-> "AIF1 Capture"

"DMIC R2"
-> "Mono DMIC R Mux"
-> "Mono ADC R2 Mux"
-> "Mono ADC MIXR"
-> "IF_ADC2"
-> "RT5650 IF1 ADC2 Swap Mux"
-> "IF1 ADC"
-> "RT5650 IF1 ADC Mux"
-> "AIF1TX"
-> "AIF1 Capture"
