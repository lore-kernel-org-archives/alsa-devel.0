From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PC Beep or PC Speaker or just Beep? and HDA Beep
 code...
Date: Tue, 3 Nov 2009 12:01:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911031147520.5500@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
	<s5h1vklythl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AB45724431
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 12:01:57 +0100 (CET)
In-Reply-To: <s5h1vklythl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Oct 2009, Takashi Iwai wrote:

> At Thu, 22 Oct 2009 17:50:10 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> Hi,
>>
>>  	I'm changing the behaviour of Beep / PC Beep controls for HDA
>> drivers (comments?):
>>
>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=d605dbeed1b102136513e09e95217e8dc19c800d
>
> Well, IMHO, the fundamental problem is that there is no logic to
> select the beep device in the input layer.  A few line of code to
> drivers/char/keyboard.c would do that.

Yes, it would be good to have possibility to configure which input device 
will receive beep events.

> Regarding your change: I'm afraid that too frequent attach/detach
> calls aren't good.

What's too frequent? The attach/detach is called only when Beep mute 
control is toggled. I don't think that user will toggle this control as 
more as once in a normal system setup. The default value is "muted" 
(no registration) anyway.

I would really like to have the HDA Beep registration to input layer 
configurable at runtime. The control layer seems good for this job.
I can eventually add one more control with name like "Beep Register 
Switch", but the "Beep Playback Switch" does this job well.

>  Also, note that there are hardwares that still
> beep even when the beep volume is set to zero.  So, you may get a
> situation that you can't disable beep tone.

??? If you don't set HDA codec frequency registers, then the HDA 
digital beep cannot be generated.

>>  	I would like to introduce uniform naming for these controls
>> to not confuse users.
>>
>> HDA driver: Beep, PC Beep
>> AC97: PC Speaker, Beep, PC Beep
>> etc..
>>
>>  	I think that the original purpose of PC Speaker is a beep
>> generator. Also, many SoC platforms use AC97 codecs, so removing
>> abbreviation PC might make sense. It would be probably best to change all
>> control names in drivers to 'Beep'. Comments?
>
> Yes, I agree to rename all to Beep.  The word "PC Speaker" has been
> always confusing.

I'll do this change.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
