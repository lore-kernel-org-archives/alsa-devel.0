From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] ASoC: davinci: bug fixes for DM365 voice codec driver
Date: Wed, 20 Jul 2011 17:04:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DC70C65@dbde02.ent.ti.com>
References: <1311158730-12412-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1311158730-12412-1-git-send-email-sudhakar.raj-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Sudhakar,

On Wed, Jul 20, 2011 at 16:15:30, Rajashekhara, Sudhakar wrote:
> This patch fixes the following bugs found in DaVinci voice codec driver.
> 
> a. According to DM365 voice codec data sheet at [1], before starting
>    recording or playback, ADC/DAC modules should follow a reset and
>    enable cycle. Writing a 1 to the ADC/DAC bit in the register resets
>    the module and clearing the bit to 0 will enable the module. But the
>    driver seems to be doing the reverse of it.
> 
> b. In davinci_vcif_trigger() function, a break() statement was missing
>    causing the davinci_vcif_stop() function to be called as a fallback
>    after calling davinci_vcif_start().

These should be two different patches. Also, please CC
the ALSA maintainers.

Thanks,
Sekhar
