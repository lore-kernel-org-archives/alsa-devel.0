From: Denys Dmytriyenko <denis-hqcsM7nSK1nYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v4 3/4] ARM: DaVinci: ASoC: Add mcasp support for DM646x
Date: Thu, 11 Jun 2009 21:31:07 -0400
Message-ID: <20090612013107.GA19074@denix.org>
References: <1244197720-31006-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-disposition: inline
In-reply-to: <1244197720-31006-1-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Naresh Medisetty <naresh-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Chaithrika,

On Fri, Jun 05, 2009 at 06:28:40AM -0400, Chaithrika U S wrote:
> Adds driver support for the two instances of McASP on TI's DM646x.

In patch #3 you removed struct evm_snd_platform_data:

> -struct evm_snd_platform_data {
> -	int tx_dma_ch;
> -	int rx_dma_ch;
> -};

That structure is still used in sound/soc/davinci/davinci-evm.c, until you fix 
it by patch #4:

> -static struct evm_snd_platform_data dm335evm_snd_data = {
> -       .tx_dma_ch      = DAVINCI_DMA_ASP1_TX,
> -       .rx_dma_ch      = DAVINCI_DMA_ASP1_RX,

That would break git-bisect...

-- 
Denys
