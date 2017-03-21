From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [pulseaudio-discuss] pulseaudio fails to start
 with kernel 4.11, caused by new snd_hdmi_lpe_audio module)
Date: Tue, 21 Mar 2017 15:49:31 +0100
Message-ID: <6a430d78-fecf-8b17-6b62-6f7740d8bdfb@redhat.com>
References: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
 <s5h8to0w4fs.wl-tiwai@suse.de>
 <6754b5cd-f6d0-e2e3-0f01-992946ec1b92@linux.intel.com>
 <s5hk27jjigd.wl-tiwai@suse.de>
 <1490082870.1321124.918129488.4F3143F8@webmail.messagingengine.com>
 <bba100b1-5e74-093a-7625-a7feaba1a065@redhat.com>
 <1490087065.1333106.918176776.2A6E8968@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DFDD266718
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 15:49:34 +0100 (CET)
In-Reply-To: <1490087065.1333106.918176776.2A6E8968@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun@arunraghavan.net>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 21-03-17 10:04, Arun Raghavan wrote:
>
>
> On Tue, 21 Mar 2017, at 02:26 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 21-03-17 08:54, Arun Raghavan wrote:
>>> On Tue, 21 Mar 2017, at 11:10 AM, Takashi Iwai wrote:
>>>> On Tue, 21 Mar 2017 00:09:22 +0100,
>>>> Pierre-Louis Bossart wrote:
>>>>>
>>>>> On 3/20/17 4:52 AM, Takashi Iwai wrote:
>>>>>> On Mon, 20 Mar 2017 12:42:58 +0100,
>>>>>> Hans de Goede wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Lately I've been working on fixing various issues people
>>>>>>> are having with baytrail / cherrytrail devices. One thing
>>>>>>> I noticed when moving my testing / development to 4.11 is
>>>>>>> that pulseaudio does not work (it aborts while starting)
>>>>>>> this seemed to be caused by the new snd_hdmi_lpe_audio
>>>>>>> module. If I blacklist that all is fine. Any idea what
>>>>>>> is causing this ?
>>>>>>
>>>>>> I noticed it once, too, but I had no time to check further.
>>>>>> More interestingly, PA works fine when LPE audio is the single driver
>>>>>> (i.e. blacklist Intel SST instead), too.  So it's more likely a bug in
>>>>>> PA.
>>>>>>
>>>>>> What happens when you modprobe LPE audio driver after starting the
>>>>>> session?  If it kills PA, we can debug more easily :)
>>>>>
>>>>> I've seen this as well, I could get either one of the two but not
>>>>> both, could this be due to the fact that one set of mixers is
>>>>> configured with UCM and the other driver isn't configured by UCM?
>>>>
>>>> No idea, and I had still no time to check (still processing the
>>>> pile of pending mails and other bugs :).  Let me add PA guys to Cc.
>>>
>>> Not sure if anyone here has the hardware and I haven't seen any
>>> complaints either -- having a backtrace (or even location of the assert)
>>> would be a good start.
>>
>> Ok, this is weird. Since you were asking for more info I tried to
>> collect a backtrace / logs. But what is happening is that after
>> the snd_hdmi_lpe_audio module loads, pulse does its thing and
>> then exits with a message of "killed" in gdb / on the terminal
>> from which I started it. I don't get a chance to get a backtrace
>> in gdb ...  So this does feel like a kernel bug to me, normally
>> this sort of "killed" behavior is seen on some kernel oopses...
>>
>> But dmesg is free of any oopses ?
>>
>> Anyways here is a log of pulseaudio -v first without the
>> hdmi module and then the module gets probed. Where the log
>> abruptly ends is where I got the "Killed" message on the
>> terminal.
>
> That's the kernel killing of PA for exceeding RT limits (there's a patch
> in the timers tip that'll now provide an error in dmesg).
>
> It sounds possible that there is some call to the ALSA API that we are
> making that results in the driver blocking for long enough to exceed the
> RT limit. You can verify this by setting 'realtime-scheduling = no' in
> /etc/pulse/daemon.conf and then starting PA.
>
> If that works,

Yep that works, good call.

> perf will likely be able to show you what's blocking.

I'm not all that familiar with perf, can you provide me with
a perf cmdline to start pulseaudio with which will generate a log
file with the info you are looking for ?

Regards,

Hans
