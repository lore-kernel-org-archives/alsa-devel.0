From: Tim Goetze <tim@quitte.de>
Subject: Re: init script with hotplug & usb audio
Date: Thu, 26 Sep 2002 12:40:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209261158010.628-100000@summer.quitte>
References: <200209261020.25769.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209261020.25769.baldrick@wanadoo.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Duncan Sands wrote:

>(1) the hotplug subsytem is started.  This automatically
>loads the snd-usb-audio module and the modules it
>depends on.  In particular /proc/asound/ is created.
>
>(2) the alsasound init script is run.  It detects that
>/proc/asound/ exists, and exits at once.  In particular
>it does not restore mixer levels for the cs46xx card.

you can change the order in which init scripts are run,
read your distribution's documentation. on debian, this
would mean renaming one of /etc/rc2.d/SXXalsasound or
/etc/rc2.d/SXXhotplug -- XX are two-digit numbers that
decide over the running order, the higher the later.

hth, tim




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
