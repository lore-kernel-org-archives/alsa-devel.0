From: noman pouigt <variksla@gmail.com>
Subject: Re: recording problem in beagleboard-mcbsp
Date: Tue, 31 Mar 2015 11:41:49 -0700
Message-ID: <CAES_P+-ufoqcY++WzvS42tyQLfd2zzuANNp2rPwuUk3x_Tn-jg@mail.gmail.com>
References: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>
 <CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CC5A1264F0A
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 20:41:50 +0200 (CEST)
Received: by obvd1 with SMTP id d1so41303712obv.0
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 11:41:49 -0700 (PDT)
In-Reply-To: <CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 27, 2015 at 2:20 PM, noman pouigt <variksla@gmail.com> wrote:
> On Fri, Mar 27, 2015 at 1:24 PM, noman pouigt <variksla@gmail.com> wrote:
>> Problem: not able to record with any of the devices
>> in beagleboard-xm.
>>
>> Analysis: userspace is stuck in snd_pcm_readi function
>> and kernel space i don't see snd_pcm_update_hw_ptr
>> function being called.
>>
>> Checked the I2S clocks and they are perfect and recording
>> data line is moving based on the data. I am able to do playback
>> though.
>>
>> I am using below command to do recording. Do i need to add
>> additional switches?
>>
>>
>> Linux kernel: 3.19
>>
>> root@arm:~# arecord -t wav -c 2 -r 44100 -f S32_LE -v test.wav
>> Recording WAVE 'test.wav' : Signed 32 bit Little Endian, Rate 44100 Hz, Stereo
>> Plug PCM: Linear conversion PCM (S16_LE)
>> Its setup is:
>>   stream       : CAPTURE
>>   access       : RW_INTERLEAVED
>>   format       : S32_LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 44100
>>   exact rate   : 44100 (44100/1)
>>   msbits       : 32
>>   buffer_size  : 27560
>>   period_size  : 5512
>>   period_time  : 124988
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 5512
>>   period_event : 0
>>   start_threshold  : 1
>>   stop_threshold   : 27560
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1806172160
>> Slave: Hardware PCM card 0 'omap3beagle' device 0 subdevice 0
>> Its setup is:
>>   stream       : CAPTURE
>>   access       : MMAP_INTERLEAVED
>>   format       : S16_LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 44100
>>   exact rate   : 44100 (44100/1)
>>   msbits       : 16
>>   buffer_size  : 27560
>>   period_size  : 5512
>>   period_time  : 124988
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 5512
>>   period_event : 0
>>   start_threshold  : 1
>>   stop_threshold   : 27560
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1806172160
>>   appl_ptr     : 0
>>   hw_ptr       : 0
>>
>> [   74.696319] omap-mcbsp 48074000.mcbsp: **** McBSP255 regs ****
>> [   74.696380] omap-mcbsp 48074000.mcbsp: DRR2:  0xedd0abce
>> [   74.696411] omap-mcbsp 48074000.mcbsp: DRR1:  0x0000
>> [   74.696441] omap-mcbsp 48074000.mcbsp: DXR2:  0x0000
>> [   74.696472] omap-mcbsp 48074000.mcbsp: DXR1:  0x0000
>> [   74.696502] omap-mcbsp 48074000.mcbsp: SPCR2: 0x0230
>> [   74.696533] omap-mcbsp 48074000.mcbsp: SPCR1: 0x0031
>> [   74.696563] omap-mcbsp 48074000.mcbsp: RCR2:  0x8041
>> [   74.696594] omap-mcbsp 48074000.mcbsp: RCR1:  0x0040
>> [   74.696594] omap-mcbsp 48074000.mcbsp: XCR2:  0x8041
>> [   74.696624] omap-mcbsp 48074000.mcbsp: XCR1:  0x0040
>> [   74.696655] omap-mcbsp 48074000.mcbsp: SRGR2: 0x001f
>> [   74.696685] omap-mcbsp 48074000.mcbsp: SRGR1: 0x0f00
>> [   74.696716] omap-mcbsp 48074000.mcbsp: PCR0:  0x000f
>>
>>
>> setup:
>> beagleoboard-xm
>> ubuntu distribution
>> arecord used
>> jaroslav recording application also tried
> using max98090 codec and not using twl.
I was wondering if i can get some help in this?
