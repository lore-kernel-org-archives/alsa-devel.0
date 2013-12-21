From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_hda_intel and Beats Audio
Date: Sat, 21 Dec 2013 14:46:09 +0800
Message-ID: <CAN8cciYGa_Aj_6Ev2ZQ+fNUbbiYVSwq616c1yvEvrPZM8P0vGw@mail.gmail.com>
References: <52B3275B.3070709@grm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id E6A392625E1
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 07:46:10 +0100 (CET)
Received: by mail-ig0-f172.google.com with SMTP id hl1so17022162igb.5
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 22:46:09 -0800 (PST)
In-Reply-To: <52B3275B.3070709@grm.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan McGhee <beesnees@grm.net>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2013/12/20 Dan McGhee <beesnees@grm.net>

> I have an HP Envy m6 Sleekbook model k010 with Beats Audio.  My system is
> LFS-7.4 and BLFS-7.4.
>
> Except for video replay, sound and printing my build is complete.  I do
> not have any other sound applications or "helpers" installed, particularly
> PulseAudio, except gstreamer which is for dependencies.  I'm using xcfe4
> desktop. In my troubleshooting and research I discovered "hda-jack-retask."
>  I installed it and have been "poking around" for awhile unsuccessfully.  I
> guess I just don't understand the "pin out."  This particular laptop has
> two speakers and a woofer.
>
> I ran "alsa-info.sh" and here is the section on the pins:
>
>  /sys/class/sound/hwC0D0/init_pin_configs:
>> 0x03 0x185600f0      [Jack] Digital Out at Int HDMI
>> 0x05 0x585600f0
>> 0x07 0x585600f0
>> 0x09 0x585600f0
>> 0x0b 0x585600f0
>> 0x0d 0x585600f0
>>
> and
>
>  /sys/class/sound/hwC1D0/init_pin_configs:
>> 0x0a 0x03a11020      [Jack] Mic at Ext Left
>> 0x0b 0x0321101f       [Jack] HP Out at Ext Left
>> 0x0c 0x40f000f0
>> 0x0d 0x92170110      [Fixed] Speaker at Int Front
>> 0x0e 0x40f000f0
>> 0x0f 0x40f000f0
>> 0x10 0x40f000f0
>> 0x11 0xd5a30130      [Both] Mic at Int Top
>> 0x1f 0x40f000f0
>>
>
Try retask 0x10 (mono pin) as your subwoofer  0x92170111

Pin Default 0x92170111: [Fixed] Speaker at Int Front
  Conn = Analog, Color = Unknown
  DefAssociation  = 0x1, Sequence = 0x1, Misc = 0x1


post the output of alsa-info.sh
