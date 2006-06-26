From: Andreas Schwab <schwab@suse.de>
Subject: Re: [RFC 01/12] snd-powermac: no longer handle
	anything with a layout-id property
Date: Mon, 26 Jun 2006 22:49:04 +0200
Message-ID: <jey7vjiqwv.fsf@sykes.suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9188C265
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 22:49:22 +0200 (MEST)
In-Reply-To: <20060607130910.156412000@sipsolutions.net> (Johannes Berg's
	message of "Wed, 07 Jun 2006 15:09:10 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org

Johannes Berg <johannes@sipsolutions.net> writes:

> This patch removes from snd-powermac the code that check for the layout-id
> and instead adds code that makes it refuse loading when a layout-id prope=
rty
> is present, nothing that snd-aoa should be used.

Can we get snd-powermac back as long as snd-aoa is lacking all those
features from snd-powermac?

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
