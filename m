From: Gavin Panella <gavin.panella@canonical.com>
Subject: ALSA bugs and Launchpad
Date: Wed, 8 Aug 2007 18:21:26 +0200
Message-ID: <CF02B638-B64A-4240-84C5-A57F16AC19E6@canonical.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/mixed; boundary="===============7420871495979555965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.ubuntu.com (adelie.ubuntu.com [82.211.81.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A95F10389D
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 18:22:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Tillenius Bjorn <bjorn.tillenius@canonical.com>, Reis Christian <kiko@async.com.br>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7420871495979555965==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9--23027451"
Content-Transfer-Encoding: 7bit

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9--23027451
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi,

I previously sent a similar message to webmaster@alsa-project.org, so  
apologies if you've seen this before.

We've been trying to get Launchpad (*) to watch bugs within your  
Mantis bug tracker, but we can't get a full CSV export from your  
installation. I'm guessing it's been disabled or restricted somehow,  
so I want to make a case for letting Launchpad get at it.

[* I work for Canonical Ltd. (http://www.canonical.com/) on the  
Launchpad.net site, specifically on the Bug Tracker (a.k.a. Malone).  
You can verify my signature and status as a Launchpad Developer at  
https://launchpad.net/~allenap.]

I'll explain from the beginning, so you might want to skip a few  
paragraphs if you already know something about the Launchpad Bug  
Tracker.

One feature of Launchpad is that users can add upstream dependencies  
to a bug report. For example, a display bug in Ubuntu could be filed  
on Launchpad, but be related to a bug in the core X.Org server project:
   https://bugs.launchpad.net/ubuntu/+source/xorg/+bug/38939

To add a dependency, a Launchpadder clicks "Also affects: Upstream"  
on the bug report, then enters the URL of the upstream bug report.  
Launchpad recognises this URL and will then "watch" the bug: once a  
day, Launchpad will fetch the status of the upstream bug and record  
it. Any changes are sent to bug subscribers, who might be the  
maintainers for that package in Ubuntu and who can then update the  
package with the fix.

[Note that Launchpad only tracks the status of the upstream bug. If a  
Launchpadder wants to get involved in fixing the upstream bug then  
Launchpad will direct them to the upstream bug tracker.]

We've recently added support for Mantis BT:
   Support Mantis as a remote bugtracker (and add ALSA's bugtracker)
   https://bugs.launchpad.net/malone/+bug/32266

There's also some info here: https://help.launchpad.net/Mantis

The current approach we take is simple: the code logs in to a Mantis  
instance as a guest and fetches a complete CSV export (via  
csv_export.php). Many Mantis instances return a complete export of  
all their bugs to the guest user, but the ALSA bug tracker returns  
nothing unless the search is narrowed.

This approach is not perfect (*) but it does work right now. If  
you're happy to do so, we'd be very grateful if you could let us  
fetch the full export while we're working on improvements. This will,  
amongst other things, help people working on Ubuntu be more aware of  
what's going on in the ALSA world.

[* Taking a full export is crude (we get a full export even though we  
might only be watching a single bug, we only record the status and  
resolution anyway, and CSV has a plate-full of problems out-of-the- 
box) so we're already planning improvements, like narrowing searches,  
page scraping, writing extensions for Mantis, or using MantisConnect.  
Above all, we need to play nicely with external bug trackers.]

Gavin.

--
Gavin Panella, Europe/Luxembourg
Tel: +352 26687161; GSM: +352 691739359
Skype: gavinpanella; Jabber: gavinpanella@gmail.com



--Apple-Mail-9--23027451
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGue2GUrNlNeDSML8RAuhMAJ0XCEQVyjkPf81nOinYi+CvHmRxLgCffThF
LqU0fK+WZrlHJutiJLktXFw=
=gcsJ
-----END PGP SIGNATURE-----

--Apple-Mail-9--23027451--

--===============7420871495979555965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7420871495979555965==--
