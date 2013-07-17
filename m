From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: hdmi-codec: enable OF support
Date: Wed, 17 Jul 2013 10:57:08 +0100
Message-ID: <20130717095708.GG22506@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
 <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4658362516107577660=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D059265117
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 11:57:11 +0200 (CEST)
In-Reply-To: <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Workgroup.Linux@csr.com" <Workgroup.Linux@csr.com>, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============4658362516107577660==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="slMCvwAS3D50yFKj"
Content-Disposition: inline


--slMCvwAS3D50yFKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2013 at 09:49:10AM +0100, Mark Rutland wrote:
> On Wed, Jul 17, 2013 at 07:12:15AM +0100, Barry Song wrote:

> > this makes users be able to add a hdmi-codec node in dts instead of
> > hardcoding a platform device in mach.

> Similarly to my comment on the first patch, I'm not sure this is the
> best way to wire this up to devicetree. Can this not be hung off of hdmi
> controller drivers?

This one is different to the BT case - as you say it's hanging off the
HDMI controller so the HDMI controller ought to enumerate it either as a
stub or by actually seeing a device.  The platform device is fine but
it's not something that should appear in the DT unless it's conveying
some information about what's connected there (eg, power supplies for
something soldered down on the board).

--slMCvwAS3D50yFKj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5mpxAAoJELSic+t+oim9zLEP/0w3xsSDZjM3nIPv9cDb6mPB
ltlqMnNg/YbEaXy7njI6x6HhAWxvq+NnPnD11HyPA3PITEL0e1ncphDBOHECVEcI
4vcXTglMsvkMOmrQuVHmt2peMhjvJvkrHRgIA+q6cJ3zbxYNI3A/+XC/ox9/gqhz
k5tquuHN/DRvJECy4RVn8VIwfJUkfRtpp95sKo1dTqN7B23GqpSMmZFA19dcLT70
MBjDRTWutiIu6pwin/ocnnhmL2+fP9sQLFx8YbDwyQLmDzH6V2E4Hcg03EUbKnXG
iWOPXTGUuYdF0QeScQFPVoAcrQwi/zX2e85qHMGFJ0pjC7JbHn4iAHjT0dkTCJud
71h0IkSILtc1Ng2ykiS/ANfIjxrS+9m6sDpckggjhuDluzCjUUFhKzBUV480Nwnr
7tKULPI/qJn5ZU8K1b/pXucQCDAG2Q+0P99DfL0ymQXZ4XLPKDVFoPXDeoqQ2NKm
LqKSuYRdmD4FGwD5wipPFbdYazvXiidS0b4MBgVRNbbyikTkcAnV+yfbvo0Af2Sw
lRfJzzDwmTykaNbrpaDQ47uxJAXRzHWXdzceHhdU+zMKFCqQjDb1qL7nf6Mh38IO
kjM17OgieK4tRMX0kiOvX9ASLp/OS2AohKwvZc274ARyRod70GpH7dI9MoQK5Y/n
0jYW7Hc+PcA+EGpCDuMs
=giWT
-----END PGP SIGNATURE-----

--slMCvwAS3D50yFKj--

--===============4658362516107577660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4658362516107577660==--
