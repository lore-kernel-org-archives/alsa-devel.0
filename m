From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
 in prep for ping/pong
Date: Thu, 3 Sep 2009 22:13:58 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<20090902220152.GB4495@sirena.org.uk>
	<4A9F0A8C.1040509@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4A9F0A8C.1040509-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
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
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 03, 2009 at 05:45:08, Troy Kisky wrote:
> Mark Brown wrote:
> > On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
[...]
> >
> > I'll probably also apply the first patch since nobody else seems to car=
e
> > one way or another, but I would urge you to look at changing the defaul=
t
> > for the platform data to at most select the workaround only on CPUs tha=
t
> > have problems with channel swapping - it's going to cause confusion for
> > people to have it on by default.
> >
> I think the ones without a problem use davinci-mcasp instead of davinci-i=
2s
> but share davinci-pcm. So, I don't know of any machines to exclude in dav=
inci-i2s.
> But if someone else knows, speak up.
>

In my experience too, the channel swap issues got reported only with ASP
(aka McBSP) and not with McASP.

The swap was almost always at the start of playback, and supposedly because
of the errata "2.1.5 ASP: Initialization Procedure When External Device is
Frame-Sync Master" in http://focus.ti.com/lit/er/sprz241l/sprz241l.pdf

Using EDMA acount=3D4 instead of 2 (32-bit transfers) did fix that issue on=
 the
OSS drivers but I don't recall the problem morphing into an "always channel
swapped" case.

Have you tested your patch (1/3) with DM644x EVM? If not, we can do that an=
d
see if it leads to channels being always swapped on that hardware as well.

One feedback we have received on this solution is that it does not work for
24-bit audio. In which case, implementing the workaround described in the
errata is the only way around.

Thanks,
Sekhar
