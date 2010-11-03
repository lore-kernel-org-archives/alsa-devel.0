From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v6 9/9] davinci: USB1.1 support for Omapl138-Hawkboard
Date: Wed, 3 Nov 2010 12:00:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234821C35@dbde02.ent.ti.com>
References: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
	<1288365045-2709-10-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234821A8C@dbde02.ent.ti.com>
	<AANLkTim=On41sekDRH25oEhc3mQGP3PjYokYaCGe1AgG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTim=On41sekDRH25oEhc3mQGP3PjYokYaCGe1AgG-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Victor Rodriguez <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 03, 2010 at 05:30:43, Victor Rodriguez wrote:

> >> +static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
> >> +     .set_power      = hawk_usb_set_power,
> >> +     .get_power      = hawk_usb_get_power,
> >> +     .get_oci        = hawk_usb_get_oci,
> >> +     .ocic_notify    = hawk_usb_ocic_notify,
> >> +     /* TPS2087 switch @ 5V */
> >
> > Do we have this part on the hawkboard as well?
>
> Yes the  TPS2087 is the   USB POWER MANAGER that we have on the board
> AFAIK this is the same and besides it is working, I have tested by my
> self by plugging different kind of USB devices, mas storage , Mouses
> and keyboards.

Just wanted to make sure we are not simply copying comments
over from EVM code. If you have verified this, no action
required.

> > Also, you are CCing a whole lot of folks on each patch. Instead, you can
> > automate CCing the relevant folks using --cc-cmd=<command> option  of
> > git-send-email
> >
> > Use --cc-cmd="scripts/get_maintainer.pl --pattern-depth=2 -s" to generate
> > list of relevant CCs.
> >
> > Example:
> >
> > scripts/get_maintainer.pl -f arch/arm/mach-davinci/board-omapl138-hawk.c --pattern-depth=2 -s
> >
> > gives:
> >
> > Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> > Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >
> > Recently Kevin requested all patches to CC Linux ARM Kernel mailing list so this
> > should be OK.
> >
> > scripts/get_maintainer.pl -f sound/soc/davinci/davinci-evm.c --pattern-depth=2 -s
> >
> > gives:
> >
> > Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> > Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> >
> > This is as per what Liam and Mark have been asking for.
> >
> > Also, use --dry-run with git-send-email before sending actual emails to make
> > sure the To and CC lists look good.
>
> Ok I have done this
>
> git send-email --dry-run --from "<vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>" --to
> "<vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>" --cc-cmd =scripts/get_maintainer.pl
> patches/sendedv6/*

You should just try:

git send-email --dry-run --from="<vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>" --to=davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org --cc-cmd="scripts/get_maintainer.pl --pattern-depth=2 -s"

> I just have one question on the --to i think I should put the davinci
> mailing list as minimum right ? because the cover letter just will be
> send to me

Yes. --to= should be davinci-linux-open-source-VycZQUHpC/PFrsHnngEfixTTglE0JFCO@public.gmane.org
You should automatically be CCed by git-send-email because of your
sign-offs. If needed you can add an explicit --cc="<vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>"

Thanks,
Sekhar
