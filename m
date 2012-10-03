From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 0/3] ASoC: Davinci: McASP: add support new
	McASP IP Variant
Date: Wed, 3 Oct 2012 12:57:12 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA99DA8@DBDE01.ent.ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
	<506B6A9D.3090100@gmail.com>
	<1BAFE6F6C881BF42822005164F1491C33EA99A40@DBDE01.ent.ti.com>
	<506C1E97.1070700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <506C1E97.1070700-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Girdwood,  Liam" <lrg-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 03, 2012 at 16:46:39, Daniel Mack wrote:
> On 03.10.2012 09:16, Hebbar, Gururaja wrote:
> > On Wed, Oct 03, 2012 at 03:58:45, Daniel Mack wrote:
> >> On 31.08.2012 14:50, Hebbar, Gururaja wrote:
> >>> The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
> >>> register offset and missing generic SRAM APIs support
> >>>
> >>> Changes
> >>> - Add new MCASP_VERSION_3 to identify new variant. New DT compatible
> >>>   "ti,omap2-mcasp-audio" to identify version 3 controller.
> >>> - The register offsets are handled depending on the version.
> >>> - Provide a config option to indicate missing SRAM API support.
> >>
> >> Could you give some insight which hardware this was tested on? I'm
> >> trying to get this up and running on a AM33xx board, and the patches
> >> look all reasonable to me. My problem is that I can't make the DMA
> >> engine move forward, I fail to receive a single interrupt on this
> >> peripheral after the stream starts. I will continue searching for the
> >> reason of this tomorrow, but maybe you can give me some hint by
> >> explaining your setup?
> >>
> >> Note that I'm using your patches together with Matt's from this series:
> >>
> >>   https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-rfc-v1
> >>
> >> ... but it doesn't work without those either.
> > 
> > 
> > When I started working on adding DT support to McASP driver, Matt Porter 
> > EDMA port was not yet ready. 
> > 
> > So 
> > 1. I took existing edma driver from AM335x Arago release [1] (driver + edma 
> >    device init). 
> > 2. Added this to Vaibhav's Local (linux-next + AM335x patches) tree [2] 
> > 
> > 3. Added DT support to McASP driver.
> > 
> > I tested this on AM335x EVM board. 
> 
> Hmm, so I think there's a tiny bit missing for the EDMA conversion on DT
> kernels.
> 
> > If you need the code, I can share it as a patch (I will send the patch as a 
> > private mail since the patch is huge).
> 
> Please do :) Or just push your entire tree somewhere.

I have pushed the code at below git repo
Repo :https://github.com/hvaibhav/am335x-linux
Branch : am335x-upstream-staging-audio

This includes 
1. (linux-next + AM335x patches)
2. McASP DT conversion
3. EDMA hack
4. AM335x audio specific DT blobs
5. Am335x dma DT blobs [hack]

Kindly let me know if you need any more details.

> 
> 
> Thanks,
> Daniel
> 
> 


Regards, 
Gururaja
