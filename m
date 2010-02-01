From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Some installation questions
Date: Mon, 01 Feb 2010 09:07:09 +0100
Message-ID: <4B668BAD.7020103@ivitera.com>
References: <d9690f191001300342ve4095cfl82e01a5b5118e1e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz
	(171-43-207-85.zapcechy.adsl-llu.static.bluetone.cz [85.207.43.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC9A24436
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 09:07:10 +0100 (CET)
In-Reply-To: <d9690f191001300342ve4095cfl82e01a5b5118e1e8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Klaus Schulz napsal(a):
> Hi there.
> 
> I am still maintaining the (inoffical) Ubuntu Alsa Upgrade Script over at
> http://ubuntuforums.org/showthread.php?t=1046137
> 
> 
> Perhaps somebody can give me a hint on some installation problems I am
> running into:
> 
> 
> 1. Quite some people reporting that /proc/asound/version is still showing
> the "original" revision  after running  the upgrade-script instead of
> 1.0.22.1.
> 
>    What could be the issue? What is setting /proc/asound/version?
> 
> 
> 2. I also introduced a kind of restore function. What it does is basically
> reinstalling all the required Ubuntu packages from the repo to overwrite the
> (by my script) upgraded files again.
>     a. My first problem was that I was only able to get the original modules
> activated when running the module assistant. ( module-assistant -f -t -q a-i
> alsa-source )
>        Just a re-installation of kernel packages and alsa-packages didn't
> work.
>     b. When redoing the Alsa Upgrade  after the restore (by my script) , I
> still see in /proc/asound the old Alsa version.
> 
>     Looks again a bit like I am having slight problems with the module
> handling
> 
> 

Hi,

I do not know the actual cause. But some drivers in ubuntu are put to
/lib/modules/kernel_version/ubuntu, the backports package used to put
there alsa drivers too. Installing drivers from git required removing
them from the ubuntu directory, or somehow forcing depmod -a to skip the
directory. I do not remember the details, but you might have a look at that.

Regards,

Pavel.
