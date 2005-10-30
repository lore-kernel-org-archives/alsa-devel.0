From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: objection for HP 6110 patch
Date: Sun, 30 Oct 2005 18:45:36 +0300
Message-ID: <20051030154536.GA9176@procyon.home>
References: <e76b46480510300557o1d88330as66f13ac9dbd97cd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from master.altlinux.org (master.altlinux.ru [62.118.250.235])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5CD5C170
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 16:45:54 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <e76b46480510300557o1d88330as66f13ac9dbd97cd6@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Aigars Mahinovs <aigarius@gmail.com>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 30, 2005 at 03:57:02PM +0200, Aigars Mahinovs wrote:
> This patch (http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=66d10647feb32178e1204d5b5c7126b1731efe9c)
> is a regression in functionality. I am very fond of the feature to
> control speaker and headphone volume separately. It is a very usefull
> feature and must be exposed wherever hardware alows to do so. It might
> be appropriate to make "Jack Sence" on by default, BUT it is not
> appropriate to remove separate Headphone mixer control altogether. As
> a compromise I might agree that Headphone mixer control is linked to
> Master control when the Jack Sence is on, but there MUST be an ability
> to set speaker (Master) and Headphone volumes separately for those
> users that wish to do so.

Seems that the only way to please everyone is to make three virtual
controls:

  - Master
  - Speakers
  - Headphones

and then combine their values (Real_Master = Master + Speakers,
Real_Headphones = Master + Headphones).

> Even worse - I could not revert the effect of this patch via options
> of the module - I had to comment out the changes and recompile the
> module to get the desired functionality. That is a very bad
> regression.

ac97_quirk=none should disable the hp_only part.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDZOqgW82GfkQfsqIRAhkdAKCDaZRgSLqfoQXvYlItMQducMuv9ACbBP5h
Hm9eHyStlsd/9AgFkxAgnXo=
=8vJ5
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
