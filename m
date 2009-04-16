From: Arun KS <getarunks@gmail.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 15:53:33 +0530
Message-ID: <dfeb90390904160323qdf9bcb2q56b322764a91ff4f@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
	<200904151404.37003.peter.ujfalusi@nokia.com>
	<20090415115606.GB9311@sirena.org.uk>
	<dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
	<20090416101216.GI16318@sirena.org.uk>
	<dfeb90390904160317r1c1bfad0ndf2370120b18c8e1@mail.gmail.com>
	<20090416101945.GJ16318@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.190])
	by alsa0.perex.cz (Postfix) with ESMTP id B3FA210392A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:23:34 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so216975tia.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 03:23:33 -0700 (PDT)
In-Reply-To: <20090416101945.GJ16318@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 3:49 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Apr 16, 2009 at 03:47:03PM +0530, Arun KS wrote:
>> On Thu, Apr 16, 2009 at 3:42 PM, Mark Brown <broonie@sirena.org.uk> wrot=
e:
>
>> > What sort of noise are you getting - is it just noise or is there some
>> > signal underneath the noise? ?Can you try playing a signal with no data
>> > on the left channel and see what effect that has?
>
>> Its not just noise, signal is there underneath.
>
> Could you try the test with no data on the left channel? =A0I suspect that
> the LSB of the left channel may be being processed as the MSB of the
> right channel.

I have to create one.
>
