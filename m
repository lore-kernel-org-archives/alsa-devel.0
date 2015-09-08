From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: add kcontrol to switch
 regulator to regulated/bypass state
Date: Tue, 8 Sep 2015 14:22:47 +0100
Message-ID: <20150908132247.GD9751@sirena.org.uk>
References: <1441707249-11259-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2289090209181929991=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF873265015
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 15:23:02 +0200 (CEST)
In-Reply-To: <1441707249-11259-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Nikesh.Oswal@cirrus.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2289090209181929991==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2015 at 11:14:09AM +0100, Nikesh Oswal wrote:
> When regulator is defined with SND_SOC_DAPM_REGULATOR_CONTROL_BYPASS
> flag, then a kcontrol will be created which can be used to switch
> regulator to regulated/bypass state. This will help to control the
> behaviour of the regulator based on a usecase. For example voice call
> may need a regulated voltage to acheive higher quality whereas voice
> trigger may need bypass voltage so as to save on power.

This is really not a good idea, moving a regulator from regulated to
bypass without coordination with the driver is a recipie for bugs at
best and physical damage at worst.  It's something that should be being
done by the device driver based on the current state of the device, the
general model is that we always drive to the lowest power state possible
based on what the device is currently doing.  If the device is set up to
do something that can use an unregulated supply then it should put the
supply into bypass mode without any help from userspace.

As I think we went through the last time you submitted code to the core
it is very important that we have coherent and safe abstractions that
result in code which does what it says.  The code in the core has to
work coherently for everyone, just randomly punching holes through
abstractions for system specific hacks from userspace is not going to do
that.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7uEnAAoJECTWi3JdVIfQUuYH/RIMLdAKIwMaxpX2BiDBKjG7
yVByz8DyOA+u4YkDMyiuZ+tpylg+tClFi65kM/9NDwxZlZNbjjOUNaQeUSfqgevk
Xfr4TlFvlM43nxk1iv9pxmtsSmMw6sdyW3KBizesfXMPKtXPG0G8vWCBx2w3vrbQ
Ii93nyGhgIxQ16Leu+OBGfoayeGUC+ZV6+OKy7Ji28Aj6ioskwY8PTJNuNe9p4Mh
za9p+MVURzoqH+DYX343tH6YhTxa7UgV2pOAfl7SPRbF15wz0rR4pO7Y7KsZ5Fqn
zJoTdhWC3UbfeIFToRMNZ8EB5osWO7fnKkSl389r8w8RzvXJZkuoXnENvN718M4=
=X60u
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--

--===============2289090209181929991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2289090209181929991==--
