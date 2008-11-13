From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: DaVinci: Audio: Fix swapping of
	channels at start of stereo playback
Date: Thu, 13 Nov 2008 06:32:34 -0800
Message-ID: <87prkzk871.fsf@deeprootsystems.com>
References: <1226465791-14725-1-git-send-email-naresh@ti.com>
	<20081112115001.GC8767@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20081112115001.GC8767-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Wed\, 12 Nov 2008 11\:50\:02 +0000")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, naresh-l0cyMroinI0@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> writes:

> On Wed, Nov 12, 2008 at 10:26:31AM +0530, naresh-l0cyMroinI0@public.gmane.org wrote:
>
>> Fixes swapping of channels at start of stereo playback.
>> 
>> Channel swap can be observed while playing left-only or right-only audio data. The channel 
>> swap is fixed by handling the XSYNCERR condition.
>> 
>> Signed-off-by: Naresh Medisetty <naresh-l0cyMroinI0@public.gmane.org>
>
> Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>
> Do you know what the status is on merging the DMA API that the ASoC
> DaVinci driver uses into mainline?

Hi Mark,

I'm the current maintainer of the DaVinci git kernel[1].  I am working
on syncing the core code (including DMA) with mainline. I may have
things ready for the next merge window, but if not, I'll definitely
have it sync'd for the next one.

Kevin

[1] git://source.mvista.com/git/linux-davinci-2.6.git
