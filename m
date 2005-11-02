From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Wed, 2 Nov 2005 18:29:51 +0000 (GMT)
Message-ID: <20051102182951.13206.qmail@web52912.mail.yahoo.com>
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
> Which rmmod triggers the oops?
> Apparently, the udev is who starts asfxload during rmmod.  Please show
> up the configuration, too, in order to check the condition.

$ cat /etc/dev.d/snd/controlC0/alsa.dev=20
#!/bin/sh -e
exec /usr/sbin/alsactl restore 0

$ cat /etc/dev.d/snd/midiC0D1/alsa.dev=20
#!/bin/sh -e
exec /usr/bin/asfxload /usr/lib/sfbank/8mbgmsfx.sf2

Cheers,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
