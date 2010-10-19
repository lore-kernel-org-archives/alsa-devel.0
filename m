From: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: RE: [PATCH v4 7/9] davinci: MMC/SD support for Omapl138-Hawkboar
Date: Tue, 19 Oct 2010 02:54:13 +0100
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093EEAB44F@Cloud.RL.local>
References: <AANLkTint2jQ3NpNWk09Y+Tm-mqAaUHpteZ+wrRA_3CDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTint2jQ3NpNWk09Y+Tm-mqAaUHpteZ+wrRA_3CDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Victor Rodriguez <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Victor Rodriguez wrote:
> On Mon, Oct 18, 2010 at 8:16 PM, Jon Povey
> <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org> wrote:
>> davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org wrote:
>>> I think that you mean that I should not call gpio_direction_input if
>>> gpio_request failed am I right ?
>>
>> Yes, if gpio_request() fails that means you have not claimed that
>> gpio, something else is using it already or it's not available due
>> to other misconfiguration.
>>
>> So you shouldn't be trying to set its direction or anything like
>> that.

> Yes you are right and as I understand gpio_request will give a 0 if it
> success and because of that the warning never will appear, if there is
> a problem there will be a -1 and the warning will be printed. I could
> fix this with a return that breaks the code like this
>
>        ret = gpio_request(DA850_HAWK_MMCSD_CD_PIN, "MMC CD\n");
>                if (ret) { pr_warning("%s: can not open GPIO %d\n",
>                        __func__, DA850_HAWK_MMCSD_CD_PIN);
>        return; }
>        gpio_direction_input(DA850_HAWK_MMCSD_CD_PIN);
>
> Is this ok ?

I haven't seen the rest of your code to tell if that is OK, but
not calling any other gpio_* functions if the request fails is
the right idea.

You may need to do more cleanup to gracefuly handle the failure,
like returning an error value at least.

--
Jon Povey
jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
