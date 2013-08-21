From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PING!] Re: HDMI audio is not working on my new
	desktop
Date: Wed, 21 Aug 2013 13:52:40 +0800
Message-ID: <CA+v+29jhLVDHQ17TRTC3ZUW2g0b-mePQSWkCrLK95v_J5DggtA@mail.gmail.com>
References: <CAN_LGv1eGP=Krg_zRXhLhLVPv12dpybKj_fy+r=oS4nSnXRGCg@mail.gmail.com>
 <s5hbo4tmtn2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2809D261B06
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 07:53:02 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id r10so1384923pdi.41
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 22:53:01 -0700 (PDT)
In-Reply-To: <s5hbo4tmtn2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi/Alexander E. Patrakov,

2013/8/20 Takashi Iwai <tiwai@suse.de>:
> At Mon, 19 Aug 2013 21:22:22 +0600,
> Alexander E. Patrakov wrote:
>>
>> 2013/8/14 Alexander E. Patrakov <patrakov@gmail.com>:
>> > Hello.
>> >
>> > I built a new desktop PC based on the Gigabyte H87N-WIFI motherboard.
>> > It has one DVI and two HDMI outputs. However, I cannot get any sound
>> > over HDMI. The same OS image works perfectly on my laptop that also
>> > has an HDMI output.
>> >
>> > This is not a pulseaudio problem, as I don't get any sound even if I
>> > test with this command:
>> >
>> > pasuspender -- speaker-test -c2 -D hdmi:0,2  # or, for that matter, 0,0 or 0,1
>> >
>> > Alsa-info.sh has uploaded its output to
>> > http://www.alsa-project.org/db/?f=1ad7192a15ff4a70b5ddb2579476dbb98adbd929
>> >
>> > Please note this error in dmesg, it may be relevant:
>> >
>> > [    1.803595] hda_codec: invalid CONNECT_LIST verb 5[1]:0
>> > [    1.803719] hda_codec: invalid CONNECT_LIST verb 7[1]:0
>>
>> As nobody replied, I have converted this into a formal bug report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=60769
>>
>> Haswell people, _please_ comment on the bug.
>
> Xingchao, could you take a look at this bug?

sure, i will take a look at it.
But i'm afraid i cannot continue tracking from next week, i'm under
leaving process at Intel.

At first glance, i saw a lot of errors:

[  772.822663] playback write error (DMA or IRQ trouble?)
[  782.912776] playback write error (DMA or IRQ trouble?)
[  793.002904] playback write error (DMA or IRQ trouble?)
[  803.093052] playback write error (DMA or IRQ trouble?)
[  813.183205] playback write error (DMA or IRQ trouble?)
[  823.273217] playback write error (DMA or IRQ trouble?)

I know this issue on some Haswell ULT boards(STP/WTM1) because they
are not stable, and it's better to use latest BIOS image(V131 or
later).
The log message like below are not critical, in fact they're just
"Warning", it will not harm audio playback:
 [    1.803595] hda_codec: invalid CONNECT_LIST verb 5[1]:0

And seems the proper HDMI device should be pin6, i hope Alexander E.
Patrakov could help check below command at first:
speak-test -t wav -c 2 -D hw:0,7

And pleaset let me know can you reproduce this issue 100% on the same
board? Did you test on some other boards with same Hardware?

thanks
--xingchao
>
> I'll be off for traveling in this week.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
