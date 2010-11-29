From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: Blackfin ASoC drivers with multi-component
Date: Sun, 28 Nov 2010 21:27:17 -0500
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D1659B574C63@NWD2CMBX1.ad.analog.com>
References: <20101128123558.GB12683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20101128123558.GB12683-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Cai, Cliff" <Cliff.Cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org]
>Sent: Sunday, November 28, 2010 8:36 PM
>To: Mike Frysinger; Zhang, Sonic; Barry Song; Cai, Cliff
>Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org;
>uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>Subject: Blackfin ASoC drivers with multi-component
>
>I'm a little concerned that there have been no updates to the
>Blackfin audio drivers since the merge of multi-component ASoC
>(which is now in mainline and should be released as part of
>2.6.37).  This was a very big and invasive update, and
>experience with other architectures has been that there's
>usually at least some typos that need fixing.  It'd be good to
>get some confirmation that the audio drivers have at least
>been tested with current mainline - if everything worked fine
>that's obviously excellent but it'd be good if someone could
>confirm that this is the case.
>
>There was some discussion with Mike at the time the drivers
>were merged but it sounded more like "I need to get the audio
>guys to look at this"
>than a report of actual testing and there's been nothing since.
>

Hi Mark,

We are busy with 2010R1 Linux on blackfin release based on kernel 2.6.34. There is no activity in ADI on multi component audio drivers in latest 2.6.37 rc kernel. However, we are switching to the 2011 development cycle soon, which will cover some audio drivers on top of the multi-component framework.


Sonic Zhang
