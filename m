From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: /dev/snd/seq unavailable with opl3 (Re: [RFC]
 ymfpci - re-enable legacy audio after suspend resume)
Date: Tue, 13 Mar 2012 19:34:41 +0800
Message-ID: <CAN8ccib8=gE=A-VaJJx619h+WM1Eh1gZTNrWiEnxmdQ0umgQ7w@mail.gmail.com>
References: <CAN8ccibfK6Cpho5F5vk8jq_gbZQKp4_C3bMcZ6Ef4c+TU2=EBQ@mail.gmail.com>
	<s5h399jpohv.wl%tiwai@suse.de>
	<CAN8ccia-mdoS4w5FHN_0tPnuCzfi2HaDb4nhZ3TdvV-8OezBvA@mail.gmail.com>
	<s5hboo6nvq9.wl%tiwai@suse.de>
	<CAN8ccib6ki86e9At-umn6nPCLa-ub4E8Gv0p2gHp=ApeEy=Lvg@mail.gmail.com>
	<s5h7gyqw7d2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AA0CA24587
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 12:34:44 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so478119wib.2
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 04:34:41 -0700 (PDT)
In-Reply-To: <s5h7gyqw7d2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/3/12, Takashi Iwai <tiwai@suse.de>:
> At Sun, 11 Mar 2012 07:37:30 +0800,
> Raymond Yau wrote:
>>
>> 2012/3/9 Takashi Iwai <tiwai@suse.de>:
>> > At Fri, 9 Mar 2012 07:28:26 +0800,
>> > Raymond Yau wrote:
>> >>
>> >> 2012/3/8, Takashi Iwai <tiwai@suse.de>:
>> >> > At Thu, 8 Mar 2012 12:12:33 +0800,
>> >> > Raymond Yau wrote:
>> >> >>
>> >> >> Since the Legacy Audio Control register is reset to default after
>> >> >> suspend resume cycle
>> >> >>
>> >> >> need to enable the Legacy Audio Control Bit in order to use OPL3 FM
>> >> >> Synth
>> >> >>
>> >> >> however it is still need to use sbiload  instrument loader to reload
>> >> >> the instruments
>> >> >
>> >> > Isn't it better to save and restore these PCI registers like below?
>> >> > It still doesn't solve the lost instrument problem, though.
>> >> >
>> >>
>> >> I only use std.o3 and drums.o3
>> >>
>> >> It seem that the playback of midi using aplaymidi can resume playback
>> >> after suspend with my ymf724f
>> >>
>> >> so it seem that there is no need to reload the instrument with your
>> >> patch
>> >>
>> >> >
>> >> > ---
>> >> > diff --git a/include/sound/ymfpci.h b/include/sound/ymfpci.h
>> >> > index 444cd6b..1e35b16 100644
>> >> > --- a/include/sound/ymfpci.h
>> >> > +++ b/include/sound/ymfpci.h
>> >> > @@ -366,6 +366,8 @@ struct snd_ymfpci {
>> >> >  #ifdef CONFIG_PM
>> >> >     u32 *saved_regs;
>> >> >     u32 saved_ydsxgr_mode;
>> >> > +   u16 saved_saved_dsxg_legacy;
>> >> > +   u16 saved_saved_dsxg_elegacy;
>> >>
>> >>
>> >> Should be saved_dsxg_legacy and save_dsxg_elegacy.
>> >
>> > Err, of course.
>> >
>> >> How can this change back port to 2.6 kernel ?
>> >
>> > I guess the patch can be applied as is.  There have been no big changes
>> > in that driver since ages.
>> >
>> >
>>
>> This patch may be useless when oss is disabled in kernel 3.x
>>
>> aplaymidi -l
>> open /dev/snd/seq failed: No such file or directory
>>
>> it only happen with snd-ymfpci  when there oss is disabled
>
> This is a different problem.  Please don't mix up.
>
> Is CONFIG_SND_OPL3_LIB_SEQ=y in your kernel config?
>
>
> Takashi
>

config1.h:#define CONFIG_SND_OPL3_LIB_SEQ_MODULE 1
linux/autoconf.h:#define CONFIG_SND_OPL3_LIB_SEQ_MODULE 1

http://thread.gmane.org/gmane.linux.alsa.devel/6363

may be specific to ymf724f which cannot enable mpu401_uart

The alsa driver does not support auto detect for fm_port and mpu_port
for ymf724f

I have to specify fm_port=388 in /etc/modprobe.conf

fm_res f514d440 ctrl 2
mpu_res 00000000 ctrl2 800

but request_region() alway return zero for  mpu_port 0x300, 0x330,
0x332 or 0x334

with oss enabled , there is no mpu401 at port 16:0

Port    Client name                      Port name
 17:0    OPL3 FM synth                    OPL3 FM Port
