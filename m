From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: Possible regression on Sigmatel 9205
Date: Wed, 15 Oct 2008 09:50:31 -0400
Message-ID: <48F5F527.7050802@embeddedalley.com>
References: <48F4AD76.8010409@aircable.net> <s5hk5ca10o5.wl%tiwai@suse.de>
	<a10be5a00810150636u2f465feey5e4050d69980d386@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id B786224703
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 15:50:59 +0200 (CEST)
In-Reply-To: <a10be5a00810150636u2f465feey5e4050d69980d386@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Naranjo <manuel@aircable.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Manuel Naranjo wrote:
>>> Hello everyone,
>>>
>>> Sorry to interrupt you all, but I had been trying to get the digital mic
>>> of my Dell Inspiron 1521 for the last 5 days without any sucess.
>>>
>>> I'm running kernel 2.6.27 with included ALSA, I also tried GIT alsa, and
>>> the result is the same, the mic works, but the volume is so damn low
>>> that there's no way to hear it.
>>>
>>> I checked dell's windows drivers and my board belongs to the M4_8 line
>>> and not to the M4_2 as suggested in alsa source. I also did a diff
>>> between M4_2 and M4_8 and there are some differences, specially in GPIO.
>>>
>>> I don't know what else to do now, I had tried everything. Last working
>>> alsa was 1.15 if I'm not wrong, but I'm not able to backport 1.15 to the
>>> new kernel, for some reason it fails to compile.
>> Do you have "Digital" volume adjusted properly (in the control name
>> "Digital Capture Volume")?
>> Usually this should be in exactly middle, which corresponds to 0dB.
> 
> Yep I did. I guess you're tired of stupid support requests. Don't
> worry I think I know what I'm doing very well. Tried with lots of
> different model options for the module too, none worked.
> 
> 
>> Anyway, please show the alsa-info.sh output with --no-upload option.
>> This will tell us more detailed information.
> Sure, I'm attaching 2 version. One is by not passing any argument to
> the module after a fresh boot, the other one is by using
> model=dell-m42 which should be mine according to my PID. BTW there are
> lots of bug tickets opened for this card over the net, most related to
> Ubuntu and kernel > 2.6.24
> 
> Thanks,
> Manuel


I only see the 'Digital Capture Volume' in the no parameters output.
You generally need to run 'arecord -f cd foo.wav' to load the digital softvol mixer.

Thanks,

Matt Ranostay
