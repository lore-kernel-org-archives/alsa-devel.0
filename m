From: Travis Place <wishie@wishie.net>
Subject: Re: alsactl init - next round
Date: Tue, 19 Aug 2008 04:23:53 +1000
Message-ID: <200808190423.54278.wishie@wishie.net>
References: <Pine.LNX.4.61.0808181706320.21669@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 3329F24469
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 20:23:57 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 28A125AAA2
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2008 18:48:05 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0808181706320.21669@tm8103-a.perex-int.cz>
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

I was wondering what the overall 'goal' of storing alsa-info.sh posts was all 
about.. now i get it. If you would like, I can request irc users to run the 
new incarnation of the script, to help fill the database.

Thanks,
Travis Place (wishie)

On Tuesday 19 August 2008 1:30:23 am Jaroslav Kysela wrote:
> Hello,
>
> 	The 'alsactl init' command becomes more powerful now.
>
> - support for dB
> - better support for enumerated controls
> - better "ready to use" udev support, expected use:
>     RUN="/usr/sbin/alsactl -r /var/run/alsactl.init restore $name"
> - initialization using a guess method - the init/default configuration
>     mostly copied from the alsaconf script, see
>    
> http://git.alsa-project.org/?p=alsa-utils.git;a=blob_plain;f=alsactl/init/d
>efault;hb=HEAD
>
> The cardinfo database is slowly filling. We have over 120 files there now.
> Any volunteer for watching of these files and writting a suitable
> configuration files for 'alsactl init' here?
>
> I'm not sure about the initialization procedure. I selected the method -
> look to database and if not found - use the default "guess" method
> (without any warranty). But the opposite way is also possible - do a
> universal initialization and modify only special parameters for specific
> hardware.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
