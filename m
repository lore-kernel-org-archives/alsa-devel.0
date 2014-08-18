From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 10/12] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
Date: Mon, 18 Aug 2014 08:56:33 -0500
Message-ID: <20140818135633.GU14537@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201454.GS17528@sirena.org.uk>
 <20140814102152.GA8028@vinod.koul@linux.intel.com>
 <20140814130708.GX17528@sirena.org.uk>
 <20140818042805.GA14041@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6572594579944999346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BC072655AA
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 15:57:08 +0200 (CEST)
In-Reply-To: <20140818042805.GA14041@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6572594579944999346==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JHjDRUnf1JOMxzko"
Content-Disposition: inline


--JHjDRUnf1JOMxzko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 09:58:11AM +0530, Subhransu S. Prusty wrote:
> On Thu, Aug 14, 2014 at 02:07:08PM +0100, Mark Brown wrote:

> > > for (i = 0; i < w->num_kcontrols; i++) {
> > > 	if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > > 		val |= 1 << i;
> > > }

> > > Is this ok?

> > No, that doesn't seem safe.  Why not read the data from the control - if
> > we were calling a function which returned the value that'd be much
> > clearer.

> So lets step back and see what is required here.

> I get a mixer update for one of the inputs of the mixer. This needs to be
> communicated to the DSP via the IPC. But the IPC expects that we send all
> the values of all the inputs of a mixer to the DSP.

> That is why here we are reading the all mixer inputs to find the values and
> send the bitmap of all inputs.

> So from the driver if I have to find out what is the value of the inputs in
> mixer, how do I do that, is there a simpler way? Or should we push
> this/<something else> into framework to query

The problem is that it looks like you are reading the value from the
control, treating it as a boolean and discarding it.

--JHjDRUnf1JOMxzko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8gXiAAoJELSic+t+oim97jEQAJYVdpslPs+AABur1IlKiSp5
zNc8dcXaRMlnuyLEiIhja9OHPSJMyNGo6K7m+hFjDX8cVtPZ72OHcnbFpvt/xlAf
5LUb9MYu9NiJ3KEyyAWCOfSc51p2vCpqaRgUybPPPrHwWFEpXqD7NLT0EAuVntjv
u40L/2QODpZwYSr6B49dDF3kzG44/ySn3emfdV3E2Pp5u3OJ18htZ3Y/fr1ccW7z
CHs31EVYdPgBePWgcNIyfMQVzbT/cwMmXleyUyhUTopLmeCROB1+WXwq7nucm7fR
4sGc2y+BKRKzyh91qgK00fCAbx036Mr26T7ceHOxIHXqndkUDRTeukvLr3NLpjZE
iHQnlqLZXu7m7jhe5iGehOs/43CCr+vMYmH+UYP/eC7djm5rG0kI4jqBQbc+WSIB
QnxlpwU3Jna7V/Kz6tdIRTaKhYvEU4rTwnTuZyfoizB+/SCkjlg2j7IwaPv1iaMn
rbcC3UNrO1ASV06ItmrXxFQkOOoYVDe3BMWQLyd1+c1s2zynvz/VwQO5PXm4fABd
VcV8bRcWfX0Z0OPS1r/oX5kO+ls1yFoVsqUlBNaL4S56vn7BjjD1Q9O9Baud90Ga
kG+srpHrMFRKK9ulEF12kFB8SiM+M6tRR8AhxkZnN0yHTStVSnNlQmJIr3GMQqib
7D14O8HOkuQxyAX7xm5N
=jh5j
-----END PGP SIGNATURE-----

--JHjDRUnf1JOMxzko--

--===============6572594579944999346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6572594579944999346==--
