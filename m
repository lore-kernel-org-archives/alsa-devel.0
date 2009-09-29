From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
 in prep for ping/pong
Date: Tue, 29 Sep 2009 16:16:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5@dbde02.ent.ti.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<20090902220152.GB4495@sirena.org.uk>	<4A9F0A8C.1040509@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>
	<4AA0113D.9030605@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD74F519@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD74F519-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2009 at 17:38:42, Nori, Sekhar wrote:
> On Fri, Sep 04, 2009 at 00:25:57, Troy Kisky wrote:
> > Nori, Sekhar wrote:
> > > On Thu, Sep 03, 2009 at 05:45:08, Troy Kisky wrote:
> > >> Mark Brown wrote:
> > >>> On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
> > > [...]
> > >>> I'll probably also apply the first patch since nobody else seems to=
 care
> > >>> one way or another, but I would urge you to look at changing the de=
fault
> > >>> for the platform data to at most select the workaround only on CPUs=
 that
> > >>> have problems with channel swapping - it's going to cause confusion=
 for
> > >>> people to have it on by default.
> > >>>
> > >> I think the ones without a problem use davinci-mcasp instead of davi=
nci-i2s
> > >> but share davinci-pcm. So, I don't know of any machines to exclude i=
n davinci-i2s.
> > >> But if someone else knows, speak up.
> > >>
>
> [...]
>
> >
> > >
> > > Using EDMA acount=3D4 instead of 2 (32-bit transfers) did fix that is=
sue on the
> > > OSS drivers but I don't recall the problem morphing into an "always c=
hannel
> > > swapped" case.
> > >
> > > Have you tested your patch (1/3) with DM644x EVM? If not, we can do t=
hat and
> > > see if it leads to channels being always swapped on that hardware as =
well.
> >
> > Yes, I have tested with dm644x, not evm. I haven't tried to hear the ch=
annel swap,
> > but I have no doubt that it is.
>
> I finally got around to testing your patch 1/3 on DM6446 EVM.
>
> Without your patch, channel swap is quite easy to reproduce using audio
> loopback:
>
> arecord -fcd | aplay -fcd
>
> The audio source is a PC which speaker balance set to an extreme.
> By starting and stopping this command repeatedly, you can see the audio
> moving from one channel to the other.
>
> Applying your patch fixes this issue.
>
> Also, I did not notice any permanent channel swap. Used aplay to play dat=
a
> which was first left-only and then right-only. Plays the same way on a Li=
nux PC.
>
> I will test on couple of other platform using davinci-i2s (DM355 etc) bef=
ore
> acking the patch.

Even on the DM355 EVM this patch fixes the random channel swap on audio
loopback 'arecord -fcd | aplay -fcd'.

However, on playback, the channels do seem to be permanently swapped. This =
cannot
surely be blamed on this patch because, without it, the channels get random=
ly
swapped.

Since this was not observed on DM6446 EVM, I have to see if the DM355 EVM
hardware swaps the channels. I briefly compared the schematics of the two E=
VMs,
but nothing seems to be wrong there.

Troy, do you have any theory yet on why your patch should permanently swap
channels?

Anyway, the patch surely improves the situation on the EVMs, so, for patch =
1/3
of this series:

Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
[tested on DM6446 and DM355 EVMs]

Thanks,
Sekhar
