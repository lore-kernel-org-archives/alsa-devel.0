From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: rme9652 locks up my computer
Date: Wed, 20 Feb 2002 10:41:43 +0000
Message-ID: <20020220104143.N25432@ecs.soton.ac.uk>
References: <004401c1b9f8$d214efe0$0300a8c0@wgilmenau> <20020220103627.M25432@ecs.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ecs.soton.ac.uk (inanna.ecs.soton.ac.uk [152.78.65.48])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA14689
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 11:41:45 +0100
Received: (from swh@localhost)
	by ecs.soton.ac.uk (8.11.6/8.11.2) id g1KAfhJ25704
	for alsa-devel@alsa-project.org; Wed, 20 Feb 2002 10:41:43 GMT
Content-Disposition: inline
In-Reply-To: <20020220103627.M25432@ecs.soton.ac.uk>; from S.W.Harris@ecs.soton.ac.uk on Wed, Feb 20, 2002 at 10:36:27 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 20, 2002 at 10:36:27 +0000, Steve Harris wrote:
> can't allocate enough ram. You can fix it by adding an entry into
> /etc/rc.d/rc.local or equivalent, but I can't remeber the exact line
> offhand.

Found it, it goes in /etc/rc.d/rc.sysinit, before the fsck part:

#
# Local mod: do this really early so that we can always grab the
# contiguous address space that we need.
#
action "Installing RME9652 memory buffers" modprobe snd-rme9652_mem
#
#
#

[ from an email from Paul D., on 2001-01-23
  http://www.geocrawler.com/archives/3/251/2001/1/100/5016441/ ]

- Steve

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
