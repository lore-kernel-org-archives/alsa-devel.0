From: louis@museresearch.com
Subject: Re: UAC2 clock selector for AudioBox 1818VSL
Date: Mon, 10 Sep 2012 10:29:40 -0700
Message-ID: <38d82baa43831f75dad50a82eaae67b9.squirrel@master.museresearch.com>
References: <76bd1b6473c857ddd3160280e278e4fb.squirrel@master.museresearch.com>
 <50490D2D.3060207@gmail.com>
 <192dce6984143a00813e593a60c5a5f4.squirrel@master.museresearch.com>
 <504B38ED.2070904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.museresearch.com (master.museresearch.com [69.59.28.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 549B02650A6
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 19:29:47 +0200 (CEST)
In-Reply-To: <504B38ED.2070904@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, louis@museresearch.com
List-Id: alsa-devel@alsa-project.org

Hi Daniel,
  I've applied the patch, and this is the output. When I call it with
value 0, nothing happens. When I set it to higher values, it looks like
some (attempted?) communication happens with the device. I added another
debug line which spits out the value_set parameter also.

[root@TestName linux-3.4.5-2.muse1.rt13.2.fc15.x86_64]# amixer -c 2 cset
numid=5,iface=MIXER,name='AudioBox 1818 VSL Clock Selector' 0

numid=5,iface=MIXER,name='AudioBox 1818 VSL Clock Selector'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'AudioBox 1818 VSL Internal Clock'
  ; Item #1 'AudioBox 1818 VSL S/PDIF Clock'
  ; Item #2 'AudioBox 1818 VSL ADAT Clock'
  : values=0

[root@TestName linux-3.4.5-2.muse1.rt13.2.fc15.x86_64]# amixer -c 2 cset
numid=5,iface=MIXER,name='AudioBox 1818 VSL Clock Selector' 1

numid=5,iface=MIXER,name='AudioBox 1818 VSL Clock Selector'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'AudioBox 1818 VSL Internal Clock'
  ; Item #1 'AudioBox 1818 VSL S/PDIF Clock'
  ; Item #2 'AudioBox 1818 VSL ADAT Clock'
  : values=0
Sep 10 09:45:16 TestName kernel: [ 4486.890466] ALSA sound/usb/mixer.c:444
Called with value_set=2
Sep 10 09:45:16 TestName kernel: [ 4486.890566] ALSA sound/usb/mixer.c:476
 DEBUG: snd_usb_mixer_set_ctl_value(): request 00000001 requesttype
00000021, value 0100, index 2800, size 2

[root@TestName linux-3.4.5-2.muse1.rt13.2.fc15.x86_64]# amixer -c 2 cset
numid=5,iface=MIXER,name='AudioBox 1818 VSL Clock Selector' 2

numid=5,iface=MIXER,name='AudioBox 1818 VSL Clock Selector'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'AudioBox 1818 VSL Internal Clock'
  ; Item #1 'AudioBox 1818 VSL S/PDIF Clock'
  ; Item #2 'AudioBox 1818 VSL ADAT Clock'
  : values=0
Sep 10 09:45:20 TestName kernel: [ 4490.090214] ALSA sound/usb/mixer.c:444
Called with value_set=3
Sep 10 09:45:20 TestName kernel: [ 4490.090256] ALSA sound/usb/mixer.c:476
 DEBUG: snd_usb_mixer_set_ctl_value(): request 00000001 requesttype
00000021, value 0100, index 2800, size 2

Louis


>> There are some other details that may be relevant, but I didn't want to
>> make my initial post too long/confusing because these extra details may
>> end up just being a red herring: Each mixer element name (as seen in
>> amixer) is prefixed with "AudioBox 1818 VSL Clock Selector" even if it
>> is
>> not a clock selector.
>
> That strange but I believe not related. We should still fix that :)
>
>> I am confident though that the control I've been
>> playing with is the clock selector because it lists the different clock
>> types as options. I also see this when I plug the device in or load the
>> ALSA driver:
>>
>> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
>> 0x201, wIndex = 0xa00, type = 4
>> ALSA sound/usb/mixer.c:846 10:0: cannot get min/max values for control 2
>> (id 10)
>> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
>> 0x200, wIndex = 0xa00, type = 4
>> ALSA sound/usb/mixer.c:846 10:0: cannot get min/max values for control 2
>> (id 10)
>> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
>> 0x201, wIndex = 0xb00, type = 4
>> ALSA sound/usb/mixer.c:846 11:0: cannot get min/max values for control 2
>> (id 11)
>> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
>> 0x200, wIndex = 0xb00, type = 4
>> ALSA sound/usb/mixer.c:846 11:0: cannot get min/max values for control 2
>> (id 11)
>
> Do you see any messages when you try to set the clock selector with
> amixer?
>
> If you're running a recent kernel, try the following patch. That will
> produce log messages for each mixer related control packet that is sent
> out to the device.
>
>
> Thanks,
> Daniel
>
>
>
>
