From: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/1] usb: gadget: f_uac2: Fix pcm sample
 size selection
Date: Tue, 22 Jul 2014 20:02:12 +0200
Message-ID: <53CEA724.2020507@zonque.org>
References: <1404411328-32566-1-git-send-email-sebastian.reimers@gmail.com> <s5hha2xu19g.wl%tiwai@suse.de> <53CE9ADF.80604@zonque.org> <20140722174448.GL20588@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140722174448.GL20588-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Sebastian Reimers <sebastian.reimers-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reimers <sebastian.reimers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/22/2014 07:44 PM, Felipe Balbi wrote:
> On Tue, Jul 22, 2014 at 07:09:51PM +0200, Daniel Mack wrote:
>> On 07/04/2014 07:43 AM, Takashi Iwai wrote:
>>> At Thu,  3 Jul 2014 20:15:28 +0200, Sebastian Reimers wrote:
>>>> 
>>>> The pcm playback and capture sample size format was fixed 
>>>> SNDRV_PCM_FMTBIT_S16_LE.
>>>> 
>>>> This patch respects also 16, 24 and 32 bit p_ssize and
>>>> c_ssize values.
>>>> 
>>>> Signed-off-by: Sebastian Reimers
>>>> <sebastian.reimers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> 
>>> In general, this driver should check more on p_ssize.  This can
>>> be any integer value passed as a module parameter.  It should
>>> be cut to a sane value or give an error in the probe function
>>> when an invalid value is given.  Ditto for p_srate and other
>>> parameters.
>>> 
>>> Also, I don't understand the logic of the code 
>>> runtime->hw.period_bytes_min = 2 * uac2->p_prm.max_psize /
>>> runtime->hw.periods_min;
>>> 
>>> But this is mostly irrelevant with this patch, so for this
>>> patch: Reviewed-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
>> 
>> Felipe, are you fine with this one?
> 
> seems like I missed this one, do you mind if we take it during
> v3.17-rc and add Cc: stable ?

I guess that was what Sebastian intended :)

Thanks for taking care of it!


Daniel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTzqckAAoJELphMRr8Y1QkzXYP/iWtHkczgDurT5s/6JNGJSv1
UsVTueRVepMLfVVFRW0mMiHHVfZVD/JoLMTAl0LkODBf95Vxgd0OR9WmHm1FVYdW
oJ80LTCkGEEjeZlZTcHJFIqfgwB6ryUsPoC+BAWvWpVSjvp2uHME8JmipYiNrwLS
fJNJSwL4lT5PFESQ27seonkDneAUk8FQObZCSOnqJsqqZpAWHmRQOPTQSyRsJ/fA
wOj/jo9gWJXqMtow2mfDteM/doiblBJaquKoQDIlj1UuEv4Ta97a1f/0N/O0q8kP
+4VqynEgCOhr8TNR8x7a6YTlzYQkonddFUGZuuJLLf5//Z5SA1zGdBl+bnZ3OPVV
7oVJZPakVaG/1ImkkPh+yUmPg6jRjaEbW6f2Y9p1t2iitnEGsi/doQpBS7xEf3+n
kHehgcKBUXCGzrJ25vxu9Q1/wUQXDXqsb3Q+PorcbhSF86OOe9pll9GvGjJbc7VY
zEitPPPKMmmLVUgyfFcsyz94NkZeAYMOCPZIBIZXtshoQGMvujUKB/qRbK5tO7x3
Y7cUnb5rSlfSuNCuRz4kKGIVK+ULr8XtdT6sSzm5kmNnqwYlxh2zt4XEPflIiRg9
4Z0MMHW4mRN0rUikfJofjsHObx/B6BvbFj7EBhyFipRZZW32b5jEn7kL5pOQRq1K
pANkTdVOnKGmgJ1VI6x8
=3cTI
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
