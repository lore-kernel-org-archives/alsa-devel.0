From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] davinci: da850: clean up pinmux arrays in da850.c
Date: Tue, 18 Jan 2011 14:41:13 +0300
Message-ID: <4D357C59.8000907@mvista.com>
References: <1294406333-30054-1-git-send-email-michael.williamson@criticallink.com>	<B85A65D85D7EB246BE421B3FB0FBB59302484733F8@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302484734D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302484734D4-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hello.

On 18-01-2011 7:40, Rajashekhara, Sudhakar wrote:

> I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
> at [1] and found that audio is broken. Below patch fixes the issue.

> ---
> From: Rajashekhara, Sudhakar<sudhakar.raj-l0cyMroinI0@public.gmane.org>

> davinci: fixes for audio on da850/omap-l138/am18x
>
> On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> has the wrong AIC3x codec slave address. This patch fixes this issue.

> Also, this patch registers the platform device for davinci-pcm-audio.

    Shouldn't this be 2 patches? I don't see a connection between the changes.

> Signed-off-by: Rajashekhara, Sudhakar<sudhakar.raj-l0cyMroinI0@public.gmane.org>

WBR, Sergei
