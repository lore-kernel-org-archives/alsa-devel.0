From: Travis Place <wishie@wishie.net>
Subject: Re: Ubuntu - Alsa Installation Script
Date: Fri, 31 Oct 2008 02:00:00 +1000
Message-ID: <200810310200.00960.wishie@wishie.net>
References: <d9690f190810300103x31492740r9aa31830ea233f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FF092448E
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 17:00:21 +0100 (CET)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 392D2EC009
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:27:22 +1000 (EST)
In-Reply-To: <d9690f190810300103x31492740r9aa31830ea233f36@mail.gmail.com>
Content-Disposition: inline
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

On Thursday 30 October 2008 6:03:55 pm Klaus Schulz wrote:
> Hi folks.
>
> I prepared an unofficial Alsa-Installation (now 1.0.18) script for the
> Ubuntu Community.
> The intention is mainly to be up2date on the drivers, since this - the lack
> or limited functionality
> of drivers (I am aware of the reasons behind it) is IMO still one of the
> biggest
> weaknesses within Linux. Therefore it is IMO crucial to have the latest
> driver available.
> As you know most of the distributions make things worse since these are
> usually one major release behind.
>
> http://ubuntuforums.org/showthread.php?t=962695
>
I will check this out, and see if i can make any suggestions.. also, you could 
specify a seperate dir to hold the NEW modules, and update the depmod search 
path (this is how i frequently tell ubuntu users to install alsa, from 
source).

> For standard installations the script seems to work fine.

We should be able to do a few tests, to determine things, and handle them 
differently etc.. If you've ever looked at the alsa-info.sh script, you'll 
know what i mean.. When originally writing that script, i wanted to take into 
account what 'interface' (if any) to use to display the output.. what 
information to collect (ac97/hda-intel) etc..

> Quite some people have been/are using it.
> And of course responding to it - mainly about problems on specific sound
> cards.
>
> I am wondering if things can be improved in the script. I would appreciate
> if
> somebody of the designers around here could have a quick look at it.

Im certainly no real expert, but it sounds like it would be a handy script, so 
worth a look into.

>
> I am not so deep into Alsa that I can cover severe problems brought up over
> there. How would you recommend to handle this?
>
> THX.
>
> Cheers
> Klaus
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Thanks,
Travis Place (wishie)
