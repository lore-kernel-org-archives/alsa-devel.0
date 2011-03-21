From: Christophe Aeschlimann <c.aeschlimann-5/WUhD8XThOVQ4qyx6sgCw@public.gmane.org>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Mon, 21 Mar 2011 13:15:37 +0100
Message-ID: <4D874169.9010202@acn-group.ch>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>	<4D5BDA3D.5080905@acn-group.ch>	<B85A65D85D7EB246BE421B3FB0FBB593024B83B5E4@dbde02.ent.ti.com>	<4D749A09.8050101@acn-group.ch>	<B85A65D85D7EB246BE421B3FB0FBB593024C0E5EC7@dbde02.ent.ti.com>	<4D762FEB.3010003@acn-group.ch>
	<4D870A59.9050004@acn-group.ch>
	<FCCFB4CDC6E5564B9182F639FC3560870370B2BA32@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370B2BA32-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 21.03.2011 12:24, Bedia, Vaibhav wrote:
> On Monday, March 21, 2011 1:51 PM, Christophe Aeschlimann wrote:
> [...]
>> In this end it was a HW issue.
>>
>> Problem solved.
>>
> =

> If you don't mind, can you please elaborate on what the h/w issue was and=
 how you fixed it?
> =

> Regards,
> Vaibhav

The symptoms were slightly different on our custom board which uses a
TLV320AIC3107 codec :

After every cold boot the system would take ~7 seconds to start
recording. Recording a second time just after the first time would
behave normally (without delay).

This delay was because the ADC (audio input) starts working when the
volts reach 1.35V (common mode) on the ADC. But a 10uF series capacitor
was delaying the ramp-up by 7 seconds. Reducing the capacitor size
changed the delay to something more reasonable (ms range).

This "issue" is described in the TLV320AIC3107 codec under "INPUT
IMPEDANCE AND VCM CONTROL" the 2nd paragraph. (they also offer a
workaround but this was not of a practical use in our case).

Hope this helps.

Regards,


-- =

Christophe Aeschlimann

Embedded Software Engineer & IT Manager

ACN Advanced Communications Networks S.A.

Rue du Puits-Godet 8a
2000 Neuch=E2tel, Switzerland

T=E9l. +41 32 724 74 31

c.aeschlimann-5/WUhD8XThOVQ4qyx6sgCw@public.gmane.org
