From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Wed, 2 Nov 2005 12:42:44 +0000 (GMT)
Message-ID: <20051102124244.52422.qmail@web52903.mail.yahoo.com>
References: <s5hwtjr70mp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtjr70mp.wl%tiwai@suse.de>
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
=20
> Which rmmod triggers the oops?
> Apparently, the udev is who starts asfxload during rmmod.  Please show
> up the configuration, too, in order to check the condition.

I'm not in front of that PC right now, but from memory, the oops happened=
 when I ran my "unalsa"
alias. This alias is basically parsing /proc/modules into awk, picking th=
ose modules beginning
with ^snd and rmmoding them. Hence it was trying to remove them *all*, in=
 the order that they
appear in /proc/modules, and I think the oops showed that it was the snd_=
hwdep module that
deadlocked while unmapping something.

I'll dig out udev's alsa.dev file when I get home.

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
