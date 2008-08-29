From: Travis Place <wishie@wishie.net>
Subject: Re: Issues with alsa-info.sh - Trying to track down
	the problem.
Date: Sat, 30 Aug 2008 04:29:36 +1000
Message-ID: <200808300429.36424.wishie@wishie.net>
References: <200808292246.06365.wishie@wishie.net>
	<200808292318.11917.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 82D4B24430
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 20:29:36 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 548B5EB373
	for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2008 18:54:12 +1000 (EST)
In-Reply-To: <200808292318.11917.wishie@wishie.net>
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

On Friday 29 August 2008 11:18:11 pm Travis Place wrote:
> On Friday 29 August 2008 10:46:06 pm Travis Place wrote:
> > Since the move to use alsa-project.org as the main place for uploads,
> > some users have reported that no URL is being printed at the end of the
> > script. I am trying to track down the problem, but would appreciate some
> > help if possible.
> >
> > Thanks in advance,
> > Travis Place (wishie)
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> When running with --debug, and checking the contents
> of /tmp/alsainfo/wget.tmp , i see the following..
>
> http://pastebin.com/d6bfd601e
>
> So it appears the alsa-project.org site is saying "Invalid file format"..
> thats a part of the puzzle. Looking into the rest now.
>
> Thanks,
> Travis Place (wishie)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Ok, the file from a failed post can be found at:

http://pastebin.ca/1188698

and the wget.tmp contents (that prove it failed) can be found at:

http://pastebin.ca/1188699

What i cant work out, is why its telling me the file is "Unknown file 
format"..

Can i see the sites code that validates the uploaded files ?

Thanks,
Travis Place (wishie)
