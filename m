From: Sebastian Droege <sebastian.droege@gmx.de>
Subject: Re: Questions regarding cs46xx support
Date: Fri, 3 May 2002 20:50:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020503205000.4fa799a2.sebastian.droege@gmx.de>
References: <HAEOIKGLLLDPLCHFOMMOMEBPCAAA.jordan.breeding@inet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.dd8RXhc,hEydaQ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA04328
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 20:51:49 +0200
In-Reply-To: <HAEOIKGLLLDPLCHFOMMOMEBPCAAA.jordan.breeding@inet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jordan Breeding <jordan.breeding@inet.com>
Cc: alsa-devel@alsa-project.org, jordan.breeding@attbi.com
List-Id: alsa-devel@alsa-project.org

--=.dd8RXhc,hEydaQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2002 12:04:50 -0500
"Jordan Breeding" <jordan.breeding@inet.com> wrote:

> Hello,
> 
>   I have a SBLive! currently and love the support in for it in alsa
> including the fact that it has multi open on /dev/dsp so that if I run esd
> for an app that needs it I can still run xmms in regular oss mode or with
> alsa drivers and not worry about the fact that esd is also using /dev/dsp.
> I do not like however the actual sound that my SBLive! produces (I never
> have) and am thinking of going back to using a Turtle Beach Santa Cruz
> (based on the cs46xx).  At one point I got to use one of these cards and was
> very impressed with the sound quality in Windows and Linux, but at the time
> alsa wasn't available as an in kernel driver (2.5.x) and the oss drivers in
> the kernel didn't support multi open on /dev/dsp for the cs46xx, so my
> question is do the newest alsa drivers for this card (Santa Cruz - cs46xx)
> support multi open through both alsa and oss emulation on /dev/dsp?  Thanks
> for any information.  Please Cc: me as I am not on the list.
Hi,
the current driver does not support multichannel output (quote from the sources):

> *    We need a DSP code to support multichannel outputs and S/PDIF.
> *    Unfortunately, it seems that Cirrus Logic, Inc. is not willing
> *    to provide us sufficient information about the DSP processor,
> *    so we can't update the driver.

There was an experimental DSP image out there but there's nothing left on the FTP (read here: http://www.ussg.iu.edu/hypermail/linux/kernel/0203.0/1304.html)
Anyone out there who has these files?

Maybe Cirrus wakes up when enough people sends them mails regarding this topic? (They haven't answered mine :()
Or maybe somebody is working on encrypting the windows drivers?
I don't know... :(

Bye
--=.dd8RXhc,hEydaQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE80tvbe9FFpVVDScsRAlwfAKC4mvUghSvXS1nfBMGPr5lkLXjtsACgmb2B
tze48tHI1omF7vCMkkGtCik=
=AohL
-----END PGP SIGNATURE-----

--=.dd8RXhc,hEydaQ--


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
