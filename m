From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 7/9] davinci: MMC/SD support for Omapl138-Hawkboar
Date: Tue, 19 Oct 2010 07:02:55 -0400
Message-ID: <4CBD7ADF.8020405@ti.com>
References: <AANLkTin-DH9eU9wSPLROVBbMj=gfxjRH=Jz=b4yUuHfi@mail.gmail.com>	<70E876B0EA86DD4BAF101844BC814DFE093EEAB44E@Cloud.RL.local>
	<AANLkTint2jQ3NpNWk09Y+Tm-mqAaUHpteZ+wrRA_3CDA@mail.gmail.com>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTint2jQ3NpNWk09Y+Tm-mqAaUHpteZ+wrRA_3CDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Hi Victor,

[...]
> Yes you are right and as I understand gpio_request will give a 0 if it
> success and because of that the warning never will appear, if there is
> a problem there will be a -1 and the warning will be printed. I could
> fix this with a return that breaks the code like this
> 
>        ret = gpio_request(DA850_HAWK_MMCSD_CD_PIN, "MMC CD\n");
>        if (ret) {
>                pr_warning("%s: can not open GPIO %d\n",
>                        __func__, DA850_HAWK_MMCSD_CD_PIN);
>                return;
>        }
>        gpio_direction_input(DA850_HAWK_MMCSD_CD_PIN);

I think gpio_request_one() is simpler.  This requests the gpio and sets
it up:

	ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
			       GPIOF_DIR_IN, "MMC CD");
	if (ret < 0) {
		... failed ...
	}

Regards
Cyril.
