From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: init script with hotplug & usb audio
Date: Fri, 27 Sep 2002 09:11:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209270911.27286.baldrick@wanadoo.fr>
References: <Pine.LNX.4.21.0209261158010.628-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0209261158010.628-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 26 September 2002 12:40, Tim Goetze wrote:
> Duncan Sands wrote:
> >(1) the hotplug subsytem is started.  This automatically
> >loads the snd-usb-audio module and the modules it
> >depends on.  In particular /proc/asound/ is created.
> >
> >(2) the alsasound init script is run.  It detects that
> >/proc/asound/ exists, and exits at once.  In particular
> >it does not restore mixer levels for the cs46xx card.
>
> you can change the order in which init scripts are run,
> read your distribution's documentation. on debian, this
> would mean renaming one of /etc/rc2.d/SXXalsasound or
> /etc/rc2.d/SXXhotplug -- XX are two-digit numbers that
> decide over the running order, the higher the later.

Sure.  On the other hand, if I plug in the usb audio device
after the init script has been run, who will restore mixer
settings for it?  In short, the solution you suggest will work
fine in most cases, but in the long term more cooperation
between the init script and hotplugging scripts will be needed.

All the best,

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
