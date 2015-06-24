From: Antonio Ospite <ao2@ao2.it>
Subject: Re: writing an alsa driver
Date: Wed, 24 Jun 2015 13:31:26 +0200
Message-ID: <20150624133126.212f5fa537d3edc537644043@ao2.it>
References: <1432819294.2726.33.camel@loki> <20150528191721.GA608@asus>
 <1432892521.2732.14.camel@loki> <20150529131753.GA339@asus>
 <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz> <20150624102157.GL19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FCBB260566
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:31:33 +0200 (CEST)
In-Reply-To: <20150624102157.GL19530@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Michele Curti <michele.curti@gmail.com>, Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Jun 2015 15:51:57 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

[...]
> For Playback you can try:
> 
> #DSP routing
> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> amixer -c0 sset 'media0_out mix 0 media1_in' on
> amixer -c0 sset 'media1_in Gain 0' 80% 
> amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'media1_in Gain 0' off
> amixer -c0 sset 'pcm0_in Gain 0' 80% 
> amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'pcm0_in Gain 0' off
> amixer -c0 sset 'codec_out0 Gain 0' 80%
> amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
> amixer -c0 sset 'codec_out0 Gain 0' off
> 
> #Codec routin, if you have different one please modfiy
> amixer -c0 sset "DAC MIXL INF1" on
> amixer -c0 sset "DAC MIXR INF1" on
> amixer -c0 sset "Stereo DAC MIXL DAC L1" on
> amixer -c0 sset "Stereo DAC MIXR DAC R1" on
> amixer -c0 sset "SPK MIXL DAC L1" on
> amixer -c0 sset "SPK MIXR DAC R1" on
> amixer -c0 sset "SPOL MIX SPKVOL L" on
> amixer -c0 sset "SPOR MIX SPKVOL R" on
> amixer -c0 sset "SPOL MIX DAC L1" on
> amixer -c0 sset "SPOR MIX DAC R1" on
> amixer -c0 sset "Speaker L" on
> amixer -c0 sset "Speaker R" on
> amixer -c0 sset "Headphone" off
> amixer -c0 sset "Ext Spk" on
> 
> I have used this in T100.
> 

OK, I guess this answers my request for a state file :)
I had not read this message yet when I wrote the other one.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
