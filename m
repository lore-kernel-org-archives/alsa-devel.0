From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Wed, 24 Jun 2015 12:40:21 +0100
Message-ID: <1435146021.2655.62.camel@loki>
References: <1432819294.2726.33.camel@loki> <20150528191721.GA608@asus>
 <1432892521.2732.14.camel@loki> <20150529131753.GA339@asus>
 <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org> <20150615164623.GA693@asus>
 <1434387868.2434.50.camel@loki> <20150623090932.GA6856@dellaz>
 <20150624102157.GL19530@localhost>
 <20150624133126.212f5fa537d3edc537644043@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 05859260559
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:40:27 +0200 (CEST)
In-Reply-To: <20150624133126.212f5fa537d3edc537644043@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Michele Curti <michele.curti@gmail.com>, Luka Karinja <luka.karinja@gmail.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-06-24 at 13:31 +0200, Antonio Ospite wrote:
> On Wed, 24 Jun 2015 15:51:57 +0530
> Vinod Koul <vinod.koul@intel.com> wrote:
> 
> [...]
> > For Playback you can try:
> > 
> > #DSP routing
> > amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> > amixer -c0 sset 'media0_out mix 0 media1_in' on
> > amixer -c0 sset 'media1_in Gain 0' 80% 
> > amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
> > amixer -c0 sset 'media1_in Gain 0' off
> > amixer -c0 sset 'pcm0_in Gain 0' 80% 
> > amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
> > amixer -c0 sset 'pcm0_in Gain 0' off
> > amixer -c0 sset 'codec_out0 Gain 0' 80%
> > amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
> > amixer -c0 sset 'codec_out0 Gain 0' off
> > 
> > #Codec routin, if you have different one please modfiy
> > amixer -c0 sset "DAC MIXL INF1" on
> > amixer -c0 sset "DAC MIXR INF1" on
> > amixer -c0 sset "Stereo DAC MIXL DAC L1" on
> > amixer -c0 sset "Stereo DAC MIXR DAC R1" on
> > amixer -c0 sset "SPK MIXL DAC L1" on
> > amixer -c0 sset "SPK MIXR DAC R1" on
> > amixer -c0 sset "SPOL MIX SPKVOL L" on
> > amixer -c0 sset "SPOR MIX SPKVOL R" on
> > amixer -c0 sset "SPOL MIX DAC L1" on
> > amixer -c0 sset "SPOR MIX DAC R1" on
> > amixer -c0 sset "Speaker L" on
> > amixer -c0 sset "Speaker R" on
> > amixer -c0 sset "Headphone" off
> > amixer -c0 sset "Ext Spk" on
> > 
> > I have used this in T100.
> > 
> 
> OK, I guess this answers my request for a state file :)
> I had not read this message yet when I wrote the other one.
> 

Might be worth creating a UCM config for this machine since there are
several different outputs.

Liam
