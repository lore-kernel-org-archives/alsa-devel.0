From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC v2 5/6] ASoc: hdmi-codec: add IEC control.
Date: Tue, 16 Feb 2016 22:16:13 +0200
Message-ID: <56C3838D.5090408@ti.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
 <1453484912-24547-6-git-send-email-arnaud.pouliquen@st.com>
 <56B649B0.3080200@ti.com> <56C1ADC5.4090207@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DD562606A3
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 21:16:20 +0100 (CET)
In-Reply-To: <56C1ADC5.4090207@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 02/15/16 12:51, Arnaud Pouliquen wrote:
>
>
> On 02/06/2016 08:29 PM, Jyri Sarha wrote:
>> On 01/22/16 19:48, Arnaud Pouliquen wrote:
>>> Create 'IEC958 Playback Default' controls to support IEC61937 formats.
>>> the use of the alsa control is optional, using 'iec_ctl' flag.
>>>
>>
>> I applied the patches "ALSA: pcm: add IEC958 channel status control
>> helper", "ASoC: core: add code to complete dai init after pcm creation",
>> and "ASoc: hdmi-codec: add IEC control" to my BBB HDMI audio branch. I
>> needed to do some trivial conflict solving, but after that everything
>> compiled fine. However, when I tried to read the iec mixer with:
>>
>> # amixer -c0 cget name='IEC958 Playback Default',device=0
>> amixer: Cannot find the given element from control hw:0
>>
>> The same command worked just fine on my intel based laptop:
>> # amixer -c0 cget iface=MIXER,name='IEC958 Playback Default',device=0
>> numid=31,iface=MIXER,name='IEC958 Playback Default'
>>     ; type=IEC958,access=rw------,values=1
>>     : values=[AES0=0x04 AES1=0x00 AES2=0x00 AES3=0x00]
> Do you enable "iec_ctl" field in hdmi_codec_pdata structure?
> i add this field because control can be declared and used by CPU DAI or
> codec, depending on hardware.
>
>>
>> How did you test the mixer yourself?
> To test on my platform i hacked my code because control is handled by
> CPU_DAI...
> But just by disabling control creation in CPU DAI for HDMI and set
> "iec_ctl" filed to 1, i can see and use the control.
>

Oh, my mistake. Simply overlooked the iec_ctl. However, when testing the 
mixer element again, I found another problem. When getting the IEC958 
value, I got following dump:

  [  690.127298]
[  690.128957] =====================================
[  690.133956] [ BUG: bad unlock balance detected! ]
[  690.138965] 4.4.0-rc6-01061-g2b96fb3-dirty #12 Not tainted
[  690.144785] -------------------------------------
[  690.149785] amixer/1409 is trying to release lock 
(&hcp->current_stream_lock) at:
[  690.157992] [<bf08a09c>] snd_pcm_iec958_get+0x1c/0x70 [snd_pcm]
[  690.164277] but there are no more locks to release!
[  690.169454]
[  690.169454] other info that might help us debug this:
[  690.176388] 2 locks held by amixer/1409:
[  690.180554]  #0:  (&card->power_lock){+.+...}, at: [<bf050f08>] 
snd_ctl_ioctl+0x514/0xcfc [snd]
[  690.190010]  #1:  (&card->controls_rwsem){++++..}, at: [<bf050f28>] 
snd_ctl_ioctl+0x534/0xcfc [snd]
[  690.199760]
[  690.199760] stack backtrace:
[  690.204409] CPU: 0 PID: 1409 Comm: amixer Not tainted 
4.4.0-rc6-01061-g2b96fb3-dirty #12
[  690.212990] Hardware name: Generic AM33XX (Flattened Device Tree)
[  690.219516] [<c0017b84>] (unwind_backtrace) from [<c0013ee8>] 
(show_stack+0x10/0x14)
[  690.227754] [<c0013ee8>] (show_stack) from [<c03480a0>] 
(dump_stack+0x84/0x9c)
[  690.235443] [<c03480a0>] (dump_stack) from [<c008ce8c>] 
(print_unlock_imbalance_bug+0xac/0xdc)
[  690.244598] [<c008ce8c>] (print_unlock_imbalance_bug) from 
[<c0091aa8>] (lock_release+0x268/0x3c0)
[  690.254125] [<c0091aa8>] (lock_release) from [<c0650c7c>] 
(__mutex_unlock_slowpath+0xb4/0x1a4)
[  690.263401] [<c0650c7c>] (__mutex_unlock_slowpath) from [<bf08a09c>] 
(snd_pcm_iec958_get+0x1c/0x70 [snd_pcm])
[  690.274104] [<bf08a09c>] (snd_pcm_iec958_get [snd_pcm]) from 
[<bf050fc4>] (snd_ctl_ioctl+0x5d0/0xcfc [snd])
[  690.284521] [<bf050fc4>] (snd_ctl_ioctl [snd]) from [<c01840bc>] 
(do_vfs_ioctl+0x4c0/0x7e4)
[  690.293405] [<c01840bc>] (do_vfs_ioctl) from [<c018444c>] 
(SyS_ioctl+0x6c/0x7c)
[  690.301191] [<c018444c>] (SyS_ioctl) from [<c000f6e0>] 
(ret_fast_syscall+0x0/0x1c)

It seems you have a bug at sound/core/pcm_iec958.c:49 (I'll comment that 
separately).

BR,
Jyri
