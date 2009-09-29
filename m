From: "Mani, Arun" <avm-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
 in prep for ping/pong
Date: Tue, 29 Sep 2009 10:21:49 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A458365@dlee02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Sekhar,
DM355 uses MCBSP 1 instead of 0 as in DM644x. Do you think this will affect=
 the channel swapping? Another thing is I was able to run aplay and arecord=
 without Troy's patches, but seems like gstreamer still fails with his patc=
hes.

Thanks,
Arun

> -----Original Message-----
> From: davinci-linux-open-source-bounces+avm=3Dti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> [mailto:davinci-linux-open-source-bounces+avm=3Dti.com-VycZQUHpC/PFrsHnngEfi/UYCXxBIdiY@public.gmane.org=
om]
> On Behalf Of Nori, Sekhar
> Sent: Tuesday, September 29, 2009 6:46 AM
> To: Nori, Sekhar; Troy Kisky
> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; Mark Brown; alsa-
> devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variable=
s
> in prep for ping/pong
>=20
> On Wed, Sep 09, 2009 at 17:38:42, Nori, Sekhar wrote:
> > On Fri, Sep 04, 2009 at 00:25:57, Troy Kisky wrote:
> > > Nori, Sekhar wrote:
> > > > On Thu, Sep 03, 2009 at 05:45:08, Troy Kisky wrote:
> > > >> Mark Brown wrote:
> > > >>> On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
> > > > [...]
> > > >>> I'll probably also apply the first patch since nobody else seems
> to care
> > > >>> one way or another, but I would urge you to look at changing the
> default
> > > >>> for the platform data to at most select the workaround only on
> CPUs that
> > > >>> have problems with channel swapping - it's going to cause
> confusion for
> > > >>> people to have it on by default.
> > > >>>
> > > >> I think the ones without a problem use davinci-mcasp instead of
> davinci-i2s
> > > >> but share davinci-pcm. So, I don't know of any machines to exclude
> in davinci-i2s.
> > > >> But if someone else knows, speak up.
> > > >>
> >
> > [...]
> >
> > >
> > > >
> > > > Using EDMA acount=3D4 instead of 2 (32-bit transfers) did fix that
> issue on the
> > > > OSS drivers but I don't recall the problem morphing into an "always
> channel
> > > > swapped" case.
> > > >
> > > > Have you tested your patch (1/3) with DM644x EVM? If not, we can do
> that and
> > > > see if it leads to channels being always swapped on that hardware a=
s
> well.
> > >
> > > Yes, I have tested with dm644x, not evm. I haven't tried to hear the
> channel swap,
> > > but I have no doubt that it is.
> >
> > I finally got around to testing your patch 1/3 on DM6446 EVM.
> >
> > Without your patch, channel swap is quite easy to reproduce using audio
> > loopback:
> >
> > arecord -fcd | aplay -fcd
> >
> > The audio source is a PC which speaker balance set to an extreme.
> > By starting and stopping this command repeatedly, you can see the audio
> > moving from one channel to the other.
> >
> > Applying your patch fixes this issue.
> >
> > Also, I did not notice any permanent channel swap. Used aplay to play
> data
> > which was first left-only and then right-only. Plays the same way on a
> Linux PC.
> >
> > I will test on couple of other platform using davinci-i2s (DM355 etc)
> before
> > acking the patch.
>=20
> Even on the DM355 EVM this patch fixes the random channel swap on audio
> loopback 'arecord -fcd | aplay -fcd'.
>=20
> However, on playback, the channels do seem to be permanently swapped. Thi=
s
> cannot
> surely be blamed on this patch because, without it, the channels get
> randomly
> swapped.
>=20
> Since this was not observed on DM6446 EVM, I have to see if the DM355 EVM
> hardware swaps the channels. I briefly compared the schematics of the two
> EVMs,
> but nothing seems to be wrong there.
>=20
> Troy, do you have any theory yet on why your patch should permanently swa=
p
> channels?
>=20
> Anyway, the patch surely improves the situation on the EVMs, so, for patc=
h
> 1/3
> of this series:
>=20
> Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> [tested on DM6446 and DM355 EVMs]
>=20
> Thanks,
> Sekhar
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
