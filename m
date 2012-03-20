From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 18:12:25 +0000
Message-ID: <20120320181224.GA7133@opensource.wolfsonmicro.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
	<CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
	<20120320170444.GA6938@opensource.wolfsonmicro.com>
	<CANOLnONkvk63ABDN_mX2g79EKMgfk0H71CRLaUmXSrwa55+C7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4430641286932849002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04074243B5
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 19:12:30 +0100 (CET)
In-Reply-To: <CANOLnONkvk63ABDN_mX2g79EKMgfk0H71CRLaUmXSrwa55+C7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4430641286932849002==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 07:27:02PM +0200, Grazvydas Ignotas wrote:
> On Tue, Mar 20, 2012 at 7:04 PM, Mark Brown
> > On Tue, Mar 20, 2012 at 06:15:34PM +0200, Grazvydas Ignotas wrote:

> >> I wouldn't really call them broken, it's enough to set period size to
> >> 512 with smaller start_threshold (something like 50ms) to have
> >> problems, those parameters are perfectly valid for a program trying to
> >> achieve low latency.

> > If they can't cope with the parameters they've set I'd call them broken,
> > they should've asked for more sensible parameters.

> How is the program supposed to know those parameters are invalid for
> this hardware? It could maybe detect underflows and increase period
> until underflows stop, but there might be other reasons for underflows
> like high system load. Or do you mean setting up some period size and
> doing writes of that period size is not valid thing to do? Currently,
> no matter how fast the writes come, there is an underflow after first
> write in these conditions.

In that case why is the fix specific to this application and not a
generic one?  If we're going to underflow no matter what then why make
the workaround custom?

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaMiBAAoJEBus8iNuMP3dSwAQAIL70zDy92ufeZc2M9G3flEJ
h9MBGYLroGWKhPxx2lKTm2bvk/vn+4XPHwavZ3UqqSHpCaef3KHOo98/v26KacZn
eg9Wgi2kPspMbcSt5gMvgZyyiN88zZUnLQgCgozCn+wQNeefVWOu6qQXfOWvU3EI
Fxp544uZHMaBeRIIRREWmfjFazNoRyoqlbPOPq+YPSKnghMke6aL7RAKzXM6G/Sk
ZZXyhyHmZViyHef3LLSu5zSWXqvIIo/smoMs9Uym/1h6KtHk+2uqyNlC3dNrbelg
W8Mt6hz5j5yNIixgp9LeO3mtS95GVdd2oM3WUArEpUSxsYcLn8wcHQ14gMngpZtP
MkFsZ5npg2S2tw4S6MJpF+lpCF+HHqVYVbYqcv0Jk9vhpGOvuroOU+nD24TlgYnY
1DEt++b8dKEAQVCX0/oVa3q9g/DJ26CZQ3HDGTjReoeH7TN05RLWsM/7sM/w9REQ
ZJAv95avIE482oNfAxSaLK1Dv0286ykQH+0auNvNMd5nOkmhWCNRWTj+cP+GFqWt
acq7c5mxnCnwgf3F3eF5ZMDtXuElMnWfbyVsam4SW38SUPCPyXAjDfK92/i8Sy8s
C/MV+L8v9WJB7/Axf25WckoKy2cHFoz+Ut9nnbwZ2FD4UZCmBFeyycNIWOFDJIDZ
mgooniQ0Wbv8QHInsChU
=4IhE
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============4430641286932849002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4430641286932849002==--
