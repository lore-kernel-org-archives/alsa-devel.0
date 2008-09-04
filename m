From: Caglar Akyuz <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: DaVinci ASoC DMA stalls
Date: Thu, 04 Sep 2008 20:06:58 +0300
Message-ID: <48C015B2.2070401@gmail.com>
References: <48BFE50E.3000802@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <48BFE50E.3000802-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Lokowich <lokowich-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
Cc: ALSA-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Mark Lokowich wrote:

> I've been using the DaVinci ASoC for a few months and have recently
> upgraded to the 2.6.26 based DaVinci git kernel.  Now my audio DMA
> stalls more readily after stopping an active stream.  I can manually
> trigger the event by poking the ESR to reactivate the stalled stream,
> suggesting the problem is in the ASP-to-DMA XEVT interface.  This
> problem is less prevalent in the 2.6.25 based kernel.  Any help?
> 


I don't know if this helps but, I am using ASoC code on my DaVinci board
with latest git kernel(2.6.27) and I have no visible issues with the ASoC
code. However, there may be some code-coverage issue with my usage so if you
have any test method to verify that I really don't have your problem I'll
be happy to perform some tests.

My real concern is that this code has never been built without any problems here.
First there was a separate asoc branch in davinci tree which failed to built.
I tried with 2.6.25 and there was again build issues. Finally I wasn't able to
build ASoC code with 2.6.27 so I tried to patch it. I think some part of it 
relies on some dma code which is not present in davinci tree.[1] I don't know
if everybody else is patching kernel source to build asoc support, maybe I'm
doing something wrong. I'm not sure, just FYI.

Regards,
Caglar

[1] http://linux.omap.com/pipermail/davinci-linux-open-source/2008-March/005920.html
