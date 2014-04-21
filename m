From: Mark Brown <broonie@kernel.org>
Subject: Re: Disabling DAPM from ASoC framework
Date: Mon, 21 Apr 2014 23:39:14 +0100
Message-ID: <20140421223914.GI12304@sirena.org.uk>
References: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4628252118477525201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20C1F2608B7
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 00:39:28 +0200 (CEST)
In-Reply-To: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Santhosh N M <santo4ul@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4628252118477525201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9o5tnVXBt3F5Igh5"
Content-Disposition: inline


--9o5tnVXBt3F5Igh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 21, 2014 at 01:10:42PM +0530, Santhosh N M wrote:

>    I'm a newbie to ALSA/ASoC framework. Lets say there is a requirement,
> where, the application (user space) takes the responsibility to switch
> ON/OFF the power components of the codec components (using ALSA Mixer
> Interface).

>    In this case, is there a standard way to disable DAPM from ASoC? One way
> I see (and found to be working) is setting num_dapm_widgets=0
> and num_dapm_routes=0 before invoking snd_soc_register_codec()

This isn't supported, it's mandatory to have DAPM support in drivers -
if there are no DAPM widgets it's likely things will break.  Why do you
not want to do power management?

--9o5tnVXBt3F5Igh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVZ4PAAoJELSic+t+oim9rYsP/0pJXMRY8jTYGhvFgG8nNjMH
hV8fX4xTAC7hrGygAGaA0KcXInxzmFNW5ZbT+bwOuRXCZkIM0KdB8ImvRWqgzUqz
Y1QLfzHhOuGdkI8bxiQGfTSUvCEp7iTtYNhOAv9ThRR4naqT0/gpm+wLIukLxfWI
iujpxedA4fD8neA4pRZ05ac1/wXfIPR8V+Hc3Og8KNcyH53eMEAi2XWXK+Ts2VbW
NFu5unWCSuqlptd2xGziA6wah8jNbE0ZvPQLNPCxmEokvFVFBBI99bTkqzoRzGVw
oZYAZ1Ts9RhOHddUkeKK6UPXFZ5MROVJ1QA17OA6SJaNXWu30zh7Zrg/n0JGGz1F
ooo4ysLrjBXbljfRSciNJa8PmZN0elByd036B7J2HrexQUfTuvrw3JwFTAFVaSb2
PWMhjxrTjRT1qevXP5SqM7o1v7g/xIz4UfQO5E12h3leH2Bk5PiFpffuh+FM3JjV
vXd8YTcQSudoOjikUqPwuY4ctgt74501Yf+ZFheRBk0/UM4Mvj7Zkzfv+uqEhGNg
YxsgOw6p9I67mFqCUFUqITi8k00Yoy9hCxN/thJepaRNJ2Giu1k+9h6g9K/eYQpC
R3r8LLrr/yqrJrkJku2nyRp5OwiOqg/oM4t0ODFM7hBDLrVQ0/EiU6p4MidIQrg/
OXfp3KzZZCKJBSmcXGcI
=vNBa
-----END PGP SIGNATURE-----

--9o5tnVXBt3F5Igh5--

--===============4628252118477525201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4628252118477525201==--
