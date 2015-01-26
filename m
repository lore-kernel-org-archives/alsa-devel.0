From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: Regression in kernel 3.19-rc5 for usb2 scarlett
 18i20
Date: Mon, 26 Jan 2015 08:30:14 -0600
Message-ID: <54C64F76.4010904@canonical.com>
References: <1422186142.4719.8.camel@yoda.heavyware>	<s5hh9vd1ymg.wl-tiwai@suse.de>
 <CAEw7SVG58Pbc==U5abDTYvUA0ukHnpSU4eQ5FNL77fr6Q47gGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B74F2605D7
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 15:30:14 +0100 (CET)
In-Reply-To: <CAEw7SVG58Pbc==U5abDTYvUA0ukHnpSU4eQ5FNL77fr6Q47gGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guido Aulisi <guido.aulisi@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 01/26/2015 07:28 AM, Guido Aulisi wrote:
> I will ASAP, now I'm not at home.
> IMHO I think this is something about usb than the mixer,
> because I didn't use it, I only noticed the xruns even without playing audio.
> I didn't try 3.18, because it isn't shipped with fedora yet.
> 
> Ciao
> 
> 2015-01-26 14:04 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
>> At Sun, 25 Jan 2015 12:42:22 +0100,
>> Guido Aulisi wrote:
>>>
>>> Hi,
>>> I noticed a regression in 3.19-rc5 kernel (as shipped by fedora rawhide)
>>> with usb2 focusrite scarlett 18i20.
>>> I get a lot of xruns with jack, even at 1024 frame buffer and 2 periods.
>>> In 3.17.8 it works quite well without xruns at the same settings.
>>>

Guido, Takashi,

I tried to reproduce this and failed on my Scarlett 18i8 (I don't have
any other hardware).

I've just tested Ubuntu's 3.18.2 and daily mainline 3.19-r5 as follows:
1) Setup Scarlett 18i8 w/ jack (RT, 1024 frames/period, sample rate 48k,
periods/buffer 2).
2) Launch Ardour3 and create/arm 8 tracks
3) Hit record

Using this I was unable to see any XRuns even when using Scarlett's
mixer with alsamixer in the background on 3.19.

Let me know more details.
Thanks,
--chris j arges


>>> I use a fedora 20 (64bit) laptop with 8GB ram,  I only installed the
>>> rawhide kernel to try the new included scarlett mixer, no other software
>>> components changed.
>>>
>>> I can try to do some other test, but compiling the kernel on this laptop
>>> is time consuming.
>>>
>>> Thanks
>>> Guido
>>
>> Looks like a regression in the recent rework for Scarlett devices.
>> Chris, do you have any clue?
>>
>> In anyway, Guido, could you give lsusb -v output (for the relevant
>> part)?
>>
>>
>> thanks,
>>
>> Takashi
> 
