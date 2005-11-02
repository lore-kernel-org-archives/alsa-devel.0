From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Wed, 2 Nov 2005 23:00:35 +0000 (GMT)
Message-ID: <20051102230035.3897.qmail@web52903.mail.yahoo.com>
References: <s5hek5y7r1i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hek5y7r1i.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote:
> > Anyway, could you run rmmod manually just like your script and check
> > the soft lockup at each rmmod?

I have just unloaded every snd* module one by one, by hand, without trigg=
ering the soft lockup
watchdog.
=20
> Above all, please check whether the problem at unloading happens, too,
> if the system timer is used instead of rtctimer.  I guess it's related
> to rtctimer, though.

Is it enough just to have the snd-rtctimer module loaded to do that? Beca=
use as I rule I *do* have
the snd-rtctimer module loaded.

Cheers,
Chris



	=09
___________________________________________________________=20
How much free photo storage do you get? Store your holiday=20
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
