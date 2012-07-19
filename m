From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [regression] ALSA: hda - Handle open while
	transitioning to D3.
Date: Thu, 19 Jul 2012 02:23:05 -0700
Message-ID: <CAEUnVG7vERxZNPisE3hYjmg_gZXMRGyJoALC_gAyCnp4R1cC7w@mail.gmail.com>
References: <50010B52.7060803@fisher-privat.net>
 <CAEUnVG6s9wxMjN-BQ3_iW0EDZ1A6c+UgsV-3EaBTbLVDFUVkig@mail.gmail.com>
 <500175FA.3070900@fisher-privat.net>
 <CAEUnVG5V1+00n5YOjS9qM=PFcOpUAD9AU+7_pwK+druanm43JA@mail.gmail.com>
 <50079A75.40007@fisher-privat.net>
 <CAEUnVG6hVSBjTFzkFB+tkAq3RdHcshddhZ8g1g5yT-45oUAOGQ@mail.gmail.com>
 <5007B773.7080504@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 162F42651F4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 11:23:24 +0200 (CEST)
Received: by wibhm2 with SMTP id hm2so4987903wib.2
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 02:23:26 -0700 (PDT)
In-Reply-To: <5007B773.7080504@fisher-privat.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 19, 2012 at 12:29 AM, Oleksij Rempel (fishor)
<bug-track@fisher-privat.net> wrote:
> On 19.07.2012 08:44, Dylan Reid wrote:
>>
>> On Wed, Jul 18, 2012 at 10:26 PM, Oleksij Rempel (fishor)
>> <bug-track@fisher-privat.net> wrote:
>>>
>>> On 17.07.2012 07:26, Dylan Reid wrote:
>>>>
>>>>
>>>> On Sat, Jul 14, 2012 at 6:36 AM, Oleksij Rempel (fishor)
>>>> <bug-track@fisher-privat.net> wrote:
>>>>>
>>>>>
>>>>> dmesg is in attachment
>>>>
>>>>
>>>> Thanks Oleksij,
>>>>
>>>> I didn't get much from that though.  What is your powersave timeout
>>>> set to?
>>>
>>>
>>>
>>> I do not know, it should be some default value.
>>>
>>>
>>>>   If you have time could you try adding the following and send
>>>> me the output, I have two guesses about where it is spending it's time
>>>> (no guesses about why yet though).  I've got a couple of systems with
>>>> a 269, I'll try to get some tests run on those tomorrow.
>>>
>>>
>>>
>>> result is attached.
>>>
>> Great, thanks Oleksij,
>>
>> I tried this on an ACER AC700 which also has the ALC269VB and could
>> not get anything like this to happen.  So I'm sorry to keep bothering
>> you for more information.  I attached the alsa-info.sh output, if you
>> see any interesting differences let me know.
>>
>>  From the output it looks like something is opening the driver about
>> three times a second, do you know what is doing that?  It appears to
>> be doing what it should be in this case, although it is a little hard
>> to tell.  If you could strace the process doing all the opens that
>> might provide some good info.
>>
>> Thanks again for the help.
>> Dylan
>
>
>
> Ok, i did some more testing compared the difference between battery and
> non-battery mode.
>
> first of all on non-battery mode, this part of code is not executed. I have
> no messages about "power_up cancel sync".
> Then i found some difference in syslog.
>
> Here is what pulse audio say if i reproduce this issue:
> [pulseaudio] module-alsa-card.c: Failed to open hctl/mixer for jack
> detection
Interesting, I'll try to get pulseaudio installed on my system to test
tomorrow.  Does it give any more info if you turn up the verbosity?
(set log-level to debug in /etc/pulse/daemon.conf)
