From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: SuSE 9.1 on Toshiba Satellite A105 - S4004
Date: Tue, 24 Jul 2007 02:49:24 -0700
Message-ID: <1185270564.4826.290.camel@razman.gruemaster.com>
References: <947983.8341.qm@web7901.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 38D4C2435C
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 11:49:27 +0200 (CEST)
In-Reply-To: <947983.8341.qm@web7901.mail.in.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neeraj Vaidya <neeraj.vaidya@yahoo.co.in>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Suse 9.1 has very old drivers at best.  You will need to install updated
drivers.  Personally, I'd start with a newer distro.  If you really like
Suse, install version 10.  More features and better support for your
system.

Driver wise, you will need to install alsa-driver-1.0.14 at the very
least.  To determine which version you are running, type
"cat /proc/asound/version".

On Tue, 2007-07-24 at 08:21 +0100, Neeraj Vaidya wrote:

> Hi,
> 
> I've installed this distro on my toshiba laptop.
> In YaST , when I try to configure the sound card , it says no sound card detected.
> 
> To cut a long story short , I do not get any sounds to work on my laptop.
> Sound works beautifully on XP , but I am trying to migrate all of my routine activities to linux ;)
> 
> I am a newbie to the ALSA mailing list. Have a feeling that something to do with ALSA configuration can help me sort out this problem.
> 
> When I run lspci , I do not see any audio card as being detected.
> 
> Can someone please help me out ?  Also , send me some diagnostic steps , if not the entire solution , so that we can sort this out in a series of emails , if the entire solution can not be provided in one email.
> 
> Thanks in Advance!
> -Neeraj
> 
>        
> ---------------------------------
>  Get the freedom to save as many mails as you wish. Click here to know how.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
