From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Applying Herton supplied patches ...
Date: Sat, 14 Feb 2009 22:37:39 +0000
Message-ID: <gn7h3k$p1f$1@ger.gmane.org>
References: <mailman.2735.1234638846.1965.alsa-devel@alsa-project.org>
	<499740EB.6040600@wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 800D42445D
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 23:37:52 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYT8x-0002dr-NU
	for alsa-devel@alsa-project.org; Sat, 14 Feb 2009 22:37:51 +0000
Received: from 80-192-67-147.cable.ubr10.sgyl.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 22:37:51 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.sgyl.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 22:37:51 +0000
In-Reply-To: <499740EB.6040600@wisc.edu>
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

'Twas brillig, and Guy Stalnaker at 14/02/09 22:08 did gyre and gimble:
> herton or Takashi,
> 
> How does one go about applying a patch like the ones attached to Message 
> 6?  And to which files are they applied?  I assume they are meant for 
> the alsa-driver code, but that's as much as I know (well, I know how to 
> run ./configure, make, and make sudo :).  I'd very much like to see if 
> the patches work for my HP dv4 1225.

Generally these would be applied via git-am into a local git clone of 
the sources.

As many of these patches will be to the driver this means applying the 
patches to your kernel and recompiling. It's a quite involved process 
and not really for the faint hearted.

If you really want to test them out, the easiest way would be to install 
Mandriva Cooker (the development version of Mandriva) and the latest 
kernel package. I'm not sure if these patches are in the latest cooker 
kernel yet but Herton is part of the kernel team and the patches will no 
doubt show up soon if they are not there already.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
