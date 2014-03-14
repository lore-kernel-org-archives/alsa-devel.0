From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Low volume ad1983
Date: Fri, 14 Mar 2014 13:14:29 +0800
Message-ID: <CAN8cciaAZQOQLwr5My8kin91wx4aUNAjfoYuoMSg-5UhjzTiGA@mail.gmail.com>
References: <CAN8ccibdwRr5q1yXsrt+4pBJkfd+=3p0Z6vmLGC97sUgBkmung@mail.gmail.com>
 <s5hiorixlk6.wl%tiwai@suse.de>
 <alpine.LFD.2.11.1403131025110.14918@theshire>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C23132610CF
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 06:14:30 +0100 (CET)
Received: by mail-qg0-f42.google.com with SMTP id q107so6017853qgd.1
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 22:14:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1403131025110.14918@theshire>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sam chan <schan@cs.ucr.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <cladisch@googlemail.com>
List-Id: alsa-devel@alsa-project.org

2014-03-14 1:48 GMT+08:00 sam chan <schan@cs.ucr.edu>:

>
>
> On Thu, 13 Mar 2014, Takashi Iwai wrote:
>
>  At Thu, 13 Mar 2014 21:20:46 +0800,
>> Raymond Yau wrote:
>>
>>>
>>>  sam chan wrote:
>>>>> i'm having a problem with sound volume being too low.
>>>>> i **think** it's due to the levels of my channel map being
>>>>> too low.....
>>>>>
>>>>
>>>  The channel map specifies which channel goes to which
>>>> physical output.
>>>>
>>>
>>>
>
> ok.  i thought the values were a range, because the
> controls makes it look like that.  maybe these ought
> to be changed.
>
>
>
>
>
>  my alsa-info...
>>>>> http://www.alsa-project.org/db/?f=3ba6278df3c6c4abe5196ad37f8015
>>>>> de7223ca8e
>>>>>
>>>>
>>>  Simple mixer control 'Master',0
>>>>>   Mono: Playback 37 [59%] [-39.00dB] [on]
>>>>>
>>>>
>>>  That is pretty low.
>>>>
>>>
>>>
>
> i just use the Master switch as my main volume control.
> i have PCM and other switches at 0 dB.
>
> just to clarify the problem, it's not that i can't get
> it loud enough.  it's that it's relatively quite low
> compared to Windows.  in Windows, i barely have to up
> the volume to get the same audible level.  the speakers'
> physical nob is the same for both instances.
>
>
>
>

Node 0x11 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x17 0x17]
  Connection: 1
     0x03


when loopback mixing is enabled, the current driver remove the previous
"PCM playback volume" and set the amp at 0dB which is 12 dB lower than the
previous version
