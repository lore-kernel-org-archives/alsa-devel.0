From: Andreas Schwab <schwab@suse.de>
Subject: Re: [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
Date: Fri, 30 Jun 2006 01:16:18 +0200
Message-ID: <jehd231rjx.fsf@sykes.suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de> <s5hac7yvfhe.wl%tiwai@suse.de>
	<jehd26aa25.fsf@sykes.suse.de> <jeu0631xpr.fsf@sykes.suse.de>
	<1151619973.22380.50.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1AD412A8
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 01:16:21 +0200 (MEST)
In-Reply-To: <1151619973.22380.50.camel@mindpipe> (Lee Revell's message of
	"Thu, 29 Jun 2006 18:26:12 -0400")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org

Lee Revell <rlrevell@joe-job.com> writes:

> What is the content of /proc/asound/cards?  The patches must have
> changed the card name and failed to create a matching config file
> in /usr/share/alsa/cards.

Thanks for the hint.  I have added 'AppleOnbdAudio cards.PMac' to
/usr/share/alsa/cards/aliases.conf, and it works again.

Andreas.

-- =

Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
