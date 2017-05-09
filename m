From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Mon, 8 May 2017 22:15:11 -0500
Message-ID: <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 299A9266483
 for <alsa-devel@alsa-project.org>; Tue,  9 May 2017 05:15:16 +0200 (CEST)
In-Reply-To: <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paulo Sergio <pstglia@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, mika.westerberg@linux.intel.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 5/8/17 7:57 PM, Paulo Sergio wrote:
> Adding alsa list + intel devs (Sorry for that )
>
> Inline answers for Charles Keepax questions bellow:
>
> 2017-05-08 5:24 GMT-03:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
>> On Sun, May 07, 2017 at 10:42:31PM -0300, Paulo Sergio wrote:
>>> Hi,
>>>
>>>
>>> I'm trying to make wm5102 work on Lenovo Yoga 2 1051F (Baytrail) again
>>> and  would like some tips.
>>>
>>> With a revised machine driver code [1] ( based on bytcr_rt5640 and
>>> some ports from Lenovo kernel [2]) I can initialize
>>> and setting routes with alsa mixer  [3], I still don't have sound.
>>>
>>> However now if I connect 'HPOUT1' to 'Tone Generator 1' I can hear the 1k tone.
>>> Question: When I do this association, it is using my route? (in my
>>> case CODEC OUT -> SSP0 TX -> AIF1RX)
>>> Or this internal tone generator has a direct link to HPOUTs?
>>>
>>> Here's some lines from my dmesg output while attemptig to play
>>> something (complete dmesg - see [4]):
>>>
>>> [  211.801176] arizona spi-WM510204:00: FLL1: Fref=25000000 Fout=49152000
>>> [  211.801184] arizona spi-WM510204:00: FLL1: Fvco=98304000Hz
>>> [  211.801190] arizona spi-WM510204:00: FLL1: GCD=4000
>>> [  211.801195] arizona spi-WM510204:00: FLL1: N=7 THETA=a8d LAMBDA=c35
>>> [  211.801200] arizona spi-WM510204:00: FLL1: FRATIO=0(0) OUTDIV=2 REFCLK_DIV=1
>>> [  211.801204] arizona spi-WM510204:00: FLL1: GAIN=4
>>> [  211.801210] arizona spi-WM510204:00: 173 <= a8d
>>> [  211.801227] arizona spi-WM510204:00: 174 <= c35
>>> [  211.801234] arizona spi-WM510204:00: 176 <= 40
>>> [  211.801241] arizona spi-WM510204:00: 179 <= 10
>>> [  211.813301] arizona spi-WM510204:00: 172 <= 8007
>>> [  211.813353] arizona spi-WM510204:00: 171 <= 1
>>> [  211.813366] arizona spi-WM510204:00: FLL1: Waiting for FLL lock...
>>> [  211.814098] arizona spi-WM510204:00: d23 => 100
>>> [  211.814641] arizona spi-WM510204:00: d23 => 101
>>> [  211.814651] arizona spi-WM510204:00: FLL1: FLL locked (1 polls)
>>> [  211.814660] arizona spi-WM510204:00: SYSCLK set to 49152000Hz
>>> [  211.814668] arizona spi-WM510204:00: SYSCLK set to 49152000Hz
>>> [  211.814675] arizona spi-WM510204:00: 101 <= 300
>>> [  211.814882] wm5102-codec wm5102-codec: AIF1: BCLK 1536000Hz LRCLK 48000Hz
>>> [  211.814892] arizona spi-WM510204:00: 80 <= 3
>>> [  211.815191] arizona spi-WM510204:00: 4dc <= 0
>>> [  211.815339] arizona spi-WM510204:00: 4dd <= 0
>>> [  211.815460] arizona spi-WM510204:00: 80 <= 0
>>> [  211.815662] sst-mfld-platform sst-mfld-platform: Enter: enable=1
>>> port_name=ssp0-port
>>> [  211.816833] wm5102-codec wm5102-codec: AIF1: BCLK 1536000Hz LRCLK 48000Hz
>>> [  211.816845] arizona spi-WM510204:00: 80 <= 3
>>> [  211.817030] arizona spi-WM510204:00: 4dc <= 0
>>> [  211.817287] arizona spi-WM510204:00: 4dd <= 0
>>>
>>> Thanks in advance!
>>>
>>>
>>> [1] - https://github.com/pstglia/linux/tree/lenovo_yoga2_returns
>>> [2] - https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c
>>> [3] - https://drive.google.com/file/d/0BxO6THtB865fQnQyZkx6c05Nbjg/view?usp=sharing
>>> [4] - https://drive.google.com/file/d/0BxO6THtB865fRy0xV3F0elRrUHM/view?usp=sharing
>>
>> OK good news you are getting sound from the Tone generator, that
>> likely implies things are setup sensibly on the CODEC side. My
>> suspicion would be that data is not making it over the I2S.
>> Probalby worth copying the Intel guys on the email, as I don't
>> know know much about that side of things.
>
> Copied alsa list and Intel guys (hit reply instead of reply all - my apologies)
>
>>
>> How are you setting up the I2S? As in which side is master, what
>> format are you using? Also do you see any over/underflow error,
>> does the system complain with "Error playing sample".
>
> The only part where I2S is explicity used on machine driver is this
> setting on backend DAI (SSP0-Codec)
>
> dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> | SND_SOC_DAIFMT_CBS_CFS,
>
> And after setting the routes using routes mentioned on [3], I have no
> errors, but no sound
>
> Note: Based on Lenovo code, I concluded this device uses ssp0, so I'm
> using a fw file "fw_sst_0f28_ssp0.bin" posted another thread.
> Could use the hacks used on kernel 4.11, but as I'm still testing with
> kernel 4.4, using this fw would make things easier

nope. I don't know how many issues we've fixed since 4.4 but it's not a 
matter of just swapping out one firmware with another. You'll have 
better luck with plain vanilla 4.11 + regular firmware and restarting 
modifying one of the latest machine drivers.

>
> x86_64:/data # alsa_aplay -v TNT.mp3
> Playing raw data 'TNT.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono
> Plug PCM: Rate conversion PCM (48000, sformat=U8)
> Converter: linear-interpolation
> Protocol version: 10002
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : U8
>   subformat    : STD
>   channels     : 1
>   rate         : 8000
>   exact rate   : 8000 (8000/1)
>   msbits       : 8
>   buffer_size  : 4000
>   period_size  : 1000
>   period_time  : 125000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 1000
>   period_event : 0
>   start_threshold  : 4000
>   stop_threshold   : 4000
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 262144000
> Slave: Route conversion PCM (sformat=S16_LE)
>   Transformation table:
>     0 <- 0
>     1 <- 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : U8
>   subformat    : STD
>   channels     : 1
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 8
>   buffer_size  : 24000
>   period_size  : 6000
>   period_time  : 125000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 6000
>   period_event : 0
>   start_threshold  : 24000
>   stop_threshold   : 24000
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1572864000
> Slave: Hardware PCM card 0 'baytrailcraudio' device 0 subdevice 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 24000
>   period_size  : 6000
>   period_time  : 125000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 6000
>   period_event : 0
>   start_threshold  : 24000
>   stop_threshold   : 24000
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1572864000
>   appl_ptr     : 0
>   hw_ptr       : 0
>
>
> Regards,
> Pstglia
>
