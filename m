From: "Narnakaje, Snehaprabha" <nsnehaprabha-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH v2 1/2] Davinci: DM365: Add platform	device
 for McBSP
Date: Wed, 2 Sep 2009 10:10:46 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0129C1B1BF@dlee02.ent.ti.com>
References: <1251498318-9490-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090829092245.GB7952@sirena.org.uk> <4A9BEA09.1040103@ridgerun.com>
	<20090831201119.GB4079@opensource.wolfsonmicro.com>
	<4A9C5227.4060102@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4A9C5227.4060102-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
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
To: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Miguel,

We have audio working on temp/asoc branch (patches from Chaithrika).

I think you should create the patches against temp/asoc (similar to the lat=
est patches from Troy).

If you create it against temp/asoc, you will be able to test audio on DM365=
.

Thanks
Sneha

> -----Original Message-----
> From: Miguel Aguilar [mailto:miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org]
> Sent: Monday, August 31, 2009 6:44 PM
> To: Kevin Hilman
> Cc: Mark Brown; davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; alsa-
> devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org; Diego Dompe;
> clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org; Narnakaje, Snehaprabha
> Subject: Re: [alsa-devel] [PATCH v2 1/2] Davinci: DM365: Add platform
> device for McBSP
>=20
> Kevin,
>=20
> Does the patch for DM365 EVM audio codec support should be created based
> on the
> current temp/asoc branch?
>=20
> Thanks,
>=20
> Miguel Aguilar
>=20
> Mark Brown wrote:
> > On Mon, Aug 31, 2009 at 09:19:37AM -0600, Miguel Aguilar wrote:
> >
> >> Should I create the patch against Kevin's temp/asoc branch?
> >
> > Probably, but Kevin's the one to ask here.
>=20
>=20
