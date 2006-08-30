From: Franck Routier <franck.routier@axege.com>
Subject: Re: No headphones on STAC7661
Date: Wed, 30 Aug 2006 14:32:02 +0200
Message-ID: <44F58542.9070203@axege.com>
References: <44F556E5.6010909@axege.com> <s5hr6yy5vux.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from axege.net (LNeuilly-152-22-82-133.w193-251.abo.wanadoo.fr
	[193.251.23.133])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53815CB
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Aug 2006 14:32:05 +0200 (MEST)
In-Reply-To: <s5hr6yy5vux.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

thanks for replying.

I don't how to tell which alsa version I use !..
"alsa-base" package version is : 10.0.10-4ubuntu4, so it might indicate =

10.0.10-4 version of alsa ?

Anyway, I have found the solution for my problem, by finding a bug =

report at ubuntu bugtracker (bug #33719)
see https://launchpad.net/distros/ubuntu/+source/alsa-driver/+bug/33719

What I had to do is to add "options snd-hda-intel model=3Dvaio" for the =

module,
namely in /etc/modprobe.d/snd-hda-intel on an Ubuntu box.

With this option, everything works fine.

However, it would be easier if the option could be avoided (not easy for =

a beginner to find the trick).

Thanks,
Franck

Takashi Iwai a =E9crit :
> Which version of ALSA did you try?
> At best, you should try the latest ALSA HG version.
>
>
> Takashi
>   =



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
