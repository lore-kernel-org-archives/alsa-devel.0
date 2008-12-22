From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Mon, 22 Dec 2008 11:47:32 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706231BE740@dbde02.ent.ti.com>
References: <494BE627.6060304@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <494BE627.6060304-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Medisetty,  Naresh" <naresh-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> [mailto:davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On Behalf
> Of Troy Kisky
> Sent: Friday, December 19, 2008 11:51 PM
> To: Mark Brown
> Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; davinci-linux-open-
> source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; Medisetty, Naresh
> Subject: Re: [alsa-devel] [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
>=20
> Mark Brown wrote:
> > On Thu, Dec 18, 2008 at 12:36:38PM -0700, Troy Kisky wrote:
> >
> >> Sorry, for the long series to do something so simple, but there were
> >> unresolved objections when I first posted this to the davinci list.
> >
> > What were the issues people had?
> >
> >> Hopefully, having this split into tiny pieces will make resolving
> >> those differences easier.
> >
> > It certainly makes review easier.
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>=20
> The meaning change of SND_SOC_DAIFMT_NB_NF was not liked.
> And my comment that I2S mode is not supported on davinci
> was not liked. I'll let Naresh explain.
>=20

The comment regarding I2S mode is absolutely correct, since the davinci can=
not support I2S where the codecs (like TLV320AIC23) has fixed bit clock fre=
quency. Documenting this limitation is a very good idea.

Still I find difficulty to agree with Troy regarding the meaning change of =
SND_SOC_DAIFMT_NB_NF, since the existing meaning is correct w.r.t davinci M=
cBSP.=20

> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
