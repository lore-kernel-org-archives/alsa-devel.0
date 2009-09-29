From: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
	in prep for ping/pong
Date: Tue, 29 Sep 2009 18:24:54 -0500
Message-ID: <1254266694.3160.103.camel@linux-1lbu>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<20090902220152.GB4495@sirena.org.uk>
	<4A9F0A8C.1040509@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>
	<4AA0113D.9030605@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD74F519@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5@dbde02.ent.ti.com>
	<4AC28588.9030802@boundarydevices.com>
	<1254263125.3160.76.camel@linux-1lbu>
	<4AC28AD0.7000600@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4AC28AD0.7000600-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-09-29 at 15:31 -0700, Troy Kisky wrote:
> Steve Chen wrote:
> > On Tue, 2009-09-29 at 15:09 -0700, Troy Kisky wrote:
> >>> Troy, do you have any theory yet on why your patch should permanently swap
> >>> channels?
> >>>
> >> Memory in 16 bit samples
> >> L1,R1,L2,R2
> >>
> >> Shifting out in 16 bit samples
> >> L1,R1,L2,R2
> >>
> >>
> >> Memory in 32 bit samples
> >> R1L1,R2L2,R3L3
> >>
> >> Shifting out in 32 bit samples
> >> R1L1,R2L2
> >>
> >> Codec sees 16 bit samples
> >> R1,L1,R2,L2
> >>
> > 
> > If that is the case, wouldn't we see the channel swap on DM644x as well?
> >>From Sekhar's earlier e-mail, the channel swap appears specific to DM355
> > EVM.
> > 
> > Steve
> > 
> > 
> Yes, unless an underrun causes the 1st 16 bit sample to be delayed when transmitting
> out 16 bit samples at a time. That is why the 16 bit shift leads to random swaps
> and 32 bit shifts leads to always swapped. When an underrun happens with 32 bit shifts
> the last sample (both left AND right) is merely shifted again. When an underrun happens
> with 16 bit shifts only the immediately preceding left OR right channel sample is repeated
> leading to a random swap.
> 

I see, so "random" channel swap only happens for 16 bit shift and only
after an underrun.  So if underrun does not happen, we should not see
any channel swap right?

As for the 32 bit shift, if the channels are always swapped, can we not
configure the DMA engine to automatically swap the upper and lower 16
bits to get around the issue?  Am I missing something?

Steve
