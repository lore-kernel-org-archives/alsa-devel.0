From: Matthew Robbetts <wingfeathera@gmail.com>
Subject: Re: RME HDSP9632, mute headphones
Date: Mon, 11 Oct 2010 18:48:15 +0100
Message-ID: <4CB34DDF.7060406@gmail.com>
References: <4CB1ED8F.2010008@gmail.com> <4CB2A17B.70508@faberman.de>
	<AB66E110-2A0E-4777-A8FD-674ADCB00C39@gmail.com>
	<4CB31F1D.2080603@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id D47B1244BF
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 19:48:20 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2070409wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 10:48:18 -0700 (PDT)
In-Reply-To: <4CB31F1D.2080603@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi Flo,

Thanks for your reply.


On 10/11/10 15:28, Florian Faber wrote:
> Matthew,
> 
>> Of course, you can adjust the volume digitally (though since hdspmixer overwrites all your routing every time you open it, it's a bit annoying to use). However, the card appears to have a dedicated a analogue gain stage just for the headphones. It's not a full PGA, but can be set to 0db, -6db, -12dB and mute - under windows. The ALSA driver only gives the first 3 options as controls. 
> 
> Ah, yes, that is something special with that old cards. I actually had
> to look it up in the manual.

Are you sure? I don't have one, but it looks like the AIO is very similar:
http://www.rme-audio.de/images/products/aio_set.gif

Anyhow - hardly important! :)


> 
>> I had a quick look in the code, and it seems there's a 2-bit field in the 9632 control register for controlling this. Sounds neat, as we have 4 possible values. Can anyone confirm that the unused value (0x10, IIRC) in the ALSA driver is used to mute the headphones?
> 
> I only have the sources for the newer cards, sorry. Just try it out,
> nothing bad should happen there.
> 

Hmmm, is there any advice you can give me on what might be affected or
need modifying to stay in sync? I've not contributed to a project like
this before...

The obvious ones to me are of course the driver itself, and adding a new
radio button to hdspconf. Is there anything else?

Thanks a lot,
Matt
