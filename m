From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] ALSA: hda - limit mic boost on Asus UX31[A, E]
Date: Thu, 28 Nov 2013 16:23:20 +0100
Message-ID: <52975FE8.4070307@rempel-privat.de>
References: <1385568723-4412-1-git-send-email-linux@rempel-privat.de>	<s5hd2ll6cns.wl%tiwai@suse.de>	<52963308.9090400@rempel-privat.de>	<52971181.9050306@rempel-privat.de>
 <s5hli084yi4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7335E261A57
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 16:23:21 +0100 (CET)
Received: from [192.168.1.138] ([93.218.116.213]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MUYnD-1WBad00WvL-00RKJN for
 <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 16:23:21 +0100
In-Reply-To: <s5hli084yi4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 28.11.2013 11:22, schrieb Takashi Iwai:
> At Thu, 28 Nov 2013 10:48:49 +0100,
> Oleksij Rempel wrote:
>>
>> Am 27.11.2013 18:59, schrieb Oleksij Rempel:
>>> Am 27.11.2013 17:18, schrieb Takashi Iwai:
>>>> At Wed, 27 Nov 2013 17:12:03 +0100,
>>>> Oleksij Rempel wrote:
>>>>>
>>>>> This both devices need limit for internal dmic.
>>>>>
>>>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>>>>
>>>> Ah, you have this Zenbook.  While I'll take your patch, yet a
>>>> counter-question to you:
>>>>
>>>> I got a bug report complaining that the output level on this (or
>>>> similar) machine is too low compared with Windows.  Is it so on yours,
>>>> too?
>>>
>>> I'll check it ASAP ;)
>>>
>>>> If so, does the patch below make the level equivalent?
>>>> The reporter isn't responsive, so need more better testing...
>>>>
>>>> BTW, I'd suggest to name the new fixup in your patch as
>>>> ALC269VB_FIXUP_ZENBOOK (or ALC269VB_FIXUP_ASUS_ZENBOOK) as my patch
>>>> does.
>>
>> Hi right now i did only one test:
>> On sender and reciver i use audacity to generate 1000Hz signal and to
>> capture it for measuring.
>> For microphone i use logitech c905 webcam. Distance between right
>> speaker and mic is 24cm.
>>
>> Windows and Linux was configured for maximal volume. On  linux i use
>> maximal alsa volume, not pulse. On windows no plugins are used.
>> Windwos 7 64bit, latest realtek driver.
>> Ubuntu Linux 13.10, kernel 3.12.0-031200rc6-generic.
>>
>> Both Windows and Linux have same volume. Check attachment in audacity.
>>
>> Reported issue may be result of enabled compressor plugin on windows.
>>
>> I will need some more time to test in on UX31A, there is no windows on
>> this machine.
> 
> Thanks, that's really helpful!  So, we don't need the pre-amp verbs.
> 
> I'll likely keep these verbs applied only when a special model option
> is given.

Hi Takashi,

we found by one of our LUG users same MIC_LIMIT issue. Reported codec is
ALC269VB, but subsystem pci_id overlap with some other device. Or may be
i misinterpreted some thing. Can you please take a look on it (it is
Lenovo 43308HG):

00:1b.0 0403: 8086:3b56 (rev 05)
    Subsystem: 17aa:38af
    Flags: bus master, fast devsel, latency 0, IRQ 43
    Memory at f2800000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd-hda-intel

Lenovo-B560:~$ sudo dmidecode | grep Prod
	Product Name: 43308HG
	Product Name: MoutCook


-- 
Regards,
Oleksij
