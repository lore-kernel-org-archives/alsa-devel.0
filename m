From: patrick reardon <swpatrick@earthlink.net>
Subject: Re: Hammerfall configuration
Date: Thu, 19 Dec 2002 13:52:26 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E02237A.7DC0FD55@earthlink.net>
References: <200212191130.18p6nx3RJ3NZFl40@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >line added to /etc/rc.d/rc.sysinit:
> >
> >action "Loading ALSA Hammerfall driver" modprobe snd-rme9652
> >
> >/etc/modules.conf is set to load soundcore and snd-rme9652-mem before
> >snd-rme9 652, so this takes care of it.
> 
> this is not quite right. rc.sysint should load just
> snd-rme9652-mem. it will work the way you have it, but there is no
> reason to load snd-rme9652 in rc.sysinit - this (unlike
> snd-rme9652-mem) will require loading of all of the ALSA
> infrastructure as well.

i go ahead and do it anyway so i don't have to bother with it later, but i see your
point.  the *-mem module is the only one that really needs to be loaded early.

> 
> >action "Setting Hammerfall as master clock" alsactl restore snd-rme9652
> >
> >can be added after the modprobe command.
> 
> this will happen anyway if /etc/asound.state contains the relevant
> setting for the card. that is, if you've set it to master, and ALSA is
> shutdown normally, then /etc/asound.state will be used to reset the
> state when the alsasound init script runs.

ah.  a few days ago i removed the alsasound init script and just did everything by hand
trying to debug this problem.  guess i should put it back :-[

patrick


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
