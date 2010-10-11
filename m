From: Matthew Robbetts <wingfeathera@gmail.com>
Subject: Re: RME HDSP9632, mute headphones
Date: Mon, 11 Oct 2010 09:35:38 +0100
Message-ID: <AB66E110-2A0E-4777-A8FD-674ADCB00C39@gmail.com>
References: <4CB1ED8F.2010008@gmail.com> <4CB2A17B.70508@faberman.de>
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B909E24418
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 10:36:34 +0200 (CEST)
Received: by wyb32 with SMTP id 32so1659013wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 01:36:34 -0700 (PDT)
In-Reply-To: <4CB2A17B.70508@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 11 Oct 2010, at 06:32, Florian Faber <faber@faberman.de> wrote:

> On 10/10/10 18:45, Matthew Robbetts wrote:
> 
>> I've just acquired myself a HDSP9632 and noticed what I think is a
>> missing feature from the drivers (compared to Windows, at least): the
>> ability to set the headphones to "mute", in addition to -6dB and -12dB
>> of gain. I would find this feature useful.
>> 
>> Is there a reason it is missing or has it just been overlooked? Or,
>> alternatively, am I doing something stupid?
> 
> This has nothing to do with the driver. You set the headphone volume
> with hdspmixer, like you would do with TotalMix on Windows/Mac.
> 

Hi Flo,

Of course, you can adjust the volume digitally (though since hdspmixer overwrites all your routing every time you open it, it's a bit annoying to use). However, the card appears to have a dedicated a analogue gain stage just for the headphones. It's not a full PGA, but can be set to 0db, -6db, -12dB and mute - under windows. The ALSA driver only gives the first 3 options as controls. 

I had a quick look in the code, and it seems there's a 2-bit field in the 9632 control register for controlling this. Sounds neat, as we have 4 possible values. Can anyone confirm that the unused value (0x10, IIRC) in the ALSA driver is used to mute the headphones?

Regards,
Matt
