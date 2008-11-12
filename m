From: Manuel Naranjo <manuel@aircable.net>
Subject: Re: Regression on alsa-driver-1.0.18a on HDA for Dell
	Inspiron 1521
Date: Wed, 12 Nov 2008 12:11:14 -0200
Message-ID: <491AE402.3030507@aircable.net>
References: <a10be5a00811120606s12672837secdda91b80659ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 94CDC24440
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 15:10:51 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so409397rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 06:10:50 -0800 (PST)
In-Reply-To: <a10be5a00811120606s12672837secdda91b80659ac8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Hello guys,
>
> I just upgraded my alsa from 1.0.16 to 1.0.18a (actually I tried
> 1.0.18 for some days, and got lots of kernel crashes, which apparently
> 1.0.18a fixes). Thing is that when I try to use my headphones with
> 1.0.18a they don't work.
>
> I'm attaching alsa-info.sh outputs for both 1.0.16 and 1.0.18a too see
> if this helps.
>
> Headphones detection works pretty well, when ever I plug the jack
> internal speakers stop working but nothing is coming from the jack. I
> can hear an static sounds, so it seems like the headphones are getting
> the bias current, but not the signal itself.
>
> Please let me know how can I help you to debug this problem.
>
> Regards,
> Manuel
>   

Ohh btw, 1.0.18a connects the hardwar beeper, which can only be disabled 
at compile time, just as a suggestion, isn't there any way to create a 
way to mute this on runtime? For advanced users like us this is no 
trouble, but for newbies this is an issue, and might scare them, the 
beep on a dell laptop is quite annoying (you can't image how annoying 
it's comming out of the headphones)
