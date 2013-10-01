From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Realtek ALC286 SONY Vaio Pro 13 Ubuntu 13.10
Date: Tue, 01 Oct 2013 08:28:24 +0200
Message-ID: <524A6B88.2080802@canonical.com>
References: <524652C0.5040207@uwo.ca> <52492D48.102@canonical.com>
 <524A67F1.5020300@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D29E2651DC
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 08:28:34 +0200 (CEST)
In-Reply-To: <524A67F1.5020300@uwo.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yuval Levy <ylevy@uwo.ca>, Kailang <kailang@realtek.com>, David Chen <david.chen@canonical.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/01/2013 08:13 AM, Yuval Levy wrote:
> Thank you for the quick reply.
> 
> On 09/30/2013 03:50 AM, David Henningsson wrote:
>> An important distinction is here: to they work in Windows without
>> specific Realtek drivers installed, or do you require Realtek's Windows
>> drivers for this support?
> 
> I am 99% certain that yes.  I am no Windows expert.  After taking
> delivery of the laptop and ascertaining that the functionality that I
> need works, I have backed up SONY's original stuff and stored it away.
> Far away.  I have reformatted the SDD, leaving 30 GB for a Windows
> install (because unfortunately, the law school's exam system requires
> either Windows or Mac).  I reinstalled Windows from Microsoft's media.
> I have not installed any other driver myself, but I am not sure if
> Windows downloads drivers from the internet.  It definitely did download
> drivers for my Brother printer, automatically and without asking for
> permission, after it discovered it on the network.  I booted into
> Windows before writing this email and looked in the Control Panel.  It
> says the driver for the two microsoft and for the loudspeakers is Microsoft.

Ok. If things work without extra drivers from Sony or Realtek, then it
should be possible to get things working in Linux too without extra
information from these parties...

>> Second, to do some actual triaging. I see you have been running
>> hda-jack-sense-test. Could you run it all three scenarios:
>>  1) nothing connected
>>  2) headphone (without mic) connected
>>  3) headset (heaphone + mic combo) connected
> 
> Done and added to the bug report. 0x21 works as you expected.  0x18 not.
> 
> As you suggested I installed alsa-tools-gui and did the advance override
> with hdajackretask:
> * selected codec Realtek ALC286
> * clicked Advance override in the Options on the right hand side
> * clicked Override under pins 0x18 and 0x21
> * changed Jack detection from Present to Not present for both pins

Ok - given that 0x21 works as expected you should only need to do this
for pin 0x18.

> * clicked Apply now
> 
> An error message appeared: Failed to create file
> '/home/yuv/.pulse/client.conf.3K083W': No such file or directory
> 
> maybe it should save to /home/yuv/.config/pulse/client.conf.3K083W?
>                                    ^^^^^^^
> I am sorry I do not know how to fix this, can you help?

Oh. That's fixed upstream [1], but apparently not in Ubuntu yet.

Any of these workarounds should do it:

 1) use the "boot override" instead (and reboot your computer to test)
 2) create a symlink from .pulse to .config/pulse
 3) or copy everything from .config/pulse to .pulse (but then you have
to restart your computer afterwards, so PulseAudio will look in .pulse
instead).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1]
http://git.alsa-project.org/?p=alsa-tools.git;a=commitdiff;h=772fbde91c00c8f9517e67e2f5401d28e9aa88d4
