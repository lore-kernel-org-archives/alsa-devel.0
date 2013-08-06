From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Tue, 6 Aug 2013 14:32:06 +0100
Message-ID: <20130806133206.GA6427@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4126433452009291943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 340AC260315
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 15:32:10 +0200 (CEST)
In-Reply-To: <20130805233015.GY23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4126433452009291943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 12:30:15AM +0100, Russell King - ARM Linux wrote:

> I put it to you that DPCM in mainline is incomplete and nonfunctional
> as it currently stands.  Moreover, it requires either those who know
> that code to continue to develop it, or someone else who understands
> the direction that this code is supposed to go picks up to complete it.

I'd be most distressed if it were far off working; it's close enough to
the out of tree code I've worked with and I know there were drivers in
progress when it was submitted.  We've certainly had at least one bug
fix from the out of tree users, I'd be surprised if we had anything more
substantial than bitrot in the current code.

> Add to that that you say that this was being developed with TI and
> the TI situation happened, it seems unlikely to me that there's any
> significant chance of movement on that.

TI isn't going to be a big problem here.  As you've seen Intel are
currently using it for Haswell and they are generally keen on
upstreaming, Qualcomm are also relying very heavily on this and the
OMAP4s are still out there albeit with a reduced development team.
There's a few others including one I expect to get round to when I'm not
spending my time writing mails like this but those the the big systems
with active use.

> So, insisting that DPCM is used for this driver is grossly unfair.

The framework can't cope with simultaneous use of both interfaces unless
DPCM is used or the framework is otherwise extended.  This is not an
unusual situation and given that there is already framework there it
would seem to be the most sensible starting point.  As is normal any
driver local approach is going to need to not get in the way of
framework development.

> Let's not forget: Liam may be working on this stuff, and may have his own
> set of patches to sort out DPCM, so having patches from me messing around
> with the DPCM code apparantly "fixing" problems with it may very well be
> counter-productive.  Again - Liam needs to provide some input on this.

Liam is on vacation this week, he'll be back next week.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAPrSAAoJELSic+t+oim91+IP/2iJgFBLmGKN7nCi+XVB9n0d
pKgOihLxahGFuPK2OtcZnwRsbO8HMAlvWuJhIj+8Nc/HmYofzEjtzZmIu8lVxht+
6Twm7yKIT2CBPCb1R9MXvTPcuvDyYSd5/ohzvOtnBR2skqgglyMh5Fb/iJUwn2Bv
eaDpuZ9gpCnti1AYd2RZ8yJtXMy1ONjddRiBFEi/XLchWVF9eeUdDgkilTFltb2j
L+dKoAd2gSkYfAHm6zHy9CNFP2VHlyFUtHIRbybS0nz0mTAhCRLZgz1YkCze+JbK
/zO4201nvhuZKnJpcd7EdpxjO1coE58gsB/jvIgG2o1fqT43mruo+/FTwtg0CXM4
xx/Tyc/tHr6Af/CsAybVK9pfT0FO7ZO57bjHs1RwOq3bI8vlxr8kQaDxrv+VrIH6
+Ua+cceETPFAh4t+0NU+wy3Wj8rlXgV/sygt7pCtKRwTKkvYCYkc/ORXQ8MWfOVW
AtAJQ3kagqzk/3nasidmZWvJmmk+1pEwIKGt+Gh1E6YXSH/XvelTgZmfTiaz4Bk8
Vk/1yjCZ6o80rD7xsu0mmT/wRCsBf+lXUhPVGtmQ0ooaiiRK3JA+aoMZ9+7eQksu
1/g70u8CXZMbhPtE1oUyaxMYYERh9iepaU/VbmTp1rXFp3flvNyYA1F8PcTAgKcy
vL3ppvye8vclae6/4dqD
=dxlv
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============4126433452009291943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4126433452009291943==--
