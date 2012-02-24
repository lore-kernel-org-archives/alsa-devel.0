From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc-core: Don't overwrite .poweroff
 in snd_soc_pm_ops
Date: Fri, 24 Feb 2012 14:46:18 +0000
Message-ID: <20120224144618.GM5450@opensource.wolfsonmicro.com>
References: <a20a22fcfed7b4e62069ef8abebfa89f557646c2.1330080832.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4421021895964469681=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D730810428E
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:46:20 +0100 (CET)
In-Reply-To: <a20a22fcfed7b4e62069ef8abebfa89f557646c2.1330080832.git.viresh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: pratyush.anand@st.com, alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com, bhupesh.sharma@st.com, armando.visconti@st.com, mirko.gardi@st.com, vipin.kumar@st.com, shiraz.hashim@st.com, amit.virdi@st.com, vipulkumar.samar@st.com, viresh.linux@gmail.com, salvatore.dedominicis@st.com, deepak.sikri@st.com, lrg@ti.com, vincenzo.frascino@st.com
List-Id: alsa-devel@alsa-project.org


--===============4421021895964469681==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HL3CiL6n73+IAdG4"
Content-Disposition: inline


--HL3CiL6n73+IAdG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 04:25:49PM +0530, Viresh Kumar wrote:
> SET_SYSTEM_SLEEP_PM_OPS writes .poweroff = *_resume once. Then we overwrite it
> again explicitly as .poweroff = snd_soc_poweroff. Even though it works, as the

Applied but please do try to use subject lines appropriate for the
subsystem you're submitting against.  I'd also suggest creating a
mailing list for ST internal people if you need to CC so many people on
your team, the vger lists have a fairly low limit on the number of CCs
they will accept which I think is about twenty or so, you're using a
fair proportion of that.

--HL3CiL6n73+IAdG4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR6K0AAoJEBus8iNuMP3dxcQQAJw4f+SCnRjm6xQFzZ7vszUZ
4rasCYGLHiH1ULYW8uCXWTmO/vmwiv925eo/kmRQfbL4HBBltCJEIGBIK6LRWh+B
1TkPBDHRH9vbzI2RAooOSp18/Z78/maUaZ4IxcKRim0mIhxh2fVlB9uO/MiO4b7/
ID463+fV4QaM2oEIDd4ll5u5NPMsK53K3CkjAZkAI76cZFIRaWAyVV0PirYNOW9R
vC/T4npbx7Krdbxp7eGH0N04s4qcvANKjy8jHlJdEGylrNPK4FY2ZmFWYXQ1SQrp
kZR9ofmwrYoZia1deJ89AW06X5DCELloxu/UjuJzUkfJof48zE19Qj2T49LVu5e0
0TdcjDdngpGJBR5cgAXK12QYDGuTNIVXxpnhZL2zk/rX1bJUh7Vb3fRgD94/o0tf
s2NEYqy8T8dcSvXnHulnenKS39lkH0MF9jsk/sZaWiccnUMYO4CfaK5U8Hu3HWIH
ViAg0uODtcPY3vzIGJJAV+SLuKRQTpg91hd8h8KG+8iLB8yLd8713VfYdvFpt9Au
10EqoEtKloYjdlv/fe1tqcHYdRU322PF6QXayR9C7bS47O0So0DrMcEtM6d0Eeo2
IZgrhb1KuDJnEgb32UrMs585CsFLvDMZr9FIl48DWkLcn3o3KMux8VpuKtQRviXO
0aYbNtJ3QIHlJduSCqrY
=+Z7b
-----END PGP SIGNATURE-----

--HL3CiL6n73+IAdG4--

--===============4421021895964469681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4421021895964469681==--
