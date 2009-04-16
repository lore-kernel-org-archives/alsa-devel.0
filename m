From: Arun KS <getarunks@gmail.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 15:38:07 +0530
Message-ID: <dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
	<200904151404.37003.peter.ujfalusi@nokia.com>
	<20090415115606.GB9311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id E116F103986
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:08:08 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so212678tia.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 03:08:07 -0700 (PDT)
In-Reply-To: <20090415115606.GB9311@sirena.org.uk>
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

On Wed, Apr 15, 2009 at 5:26 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Apr 15, 2009 at 02:04:36PM +0300, Peter Ujfalusi wrote:
>
>> I believe this is correct.
>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
>
> Excellent! =A0I'll apply both, thanks.

This patch is working(tested on osk5912), but with
SND_SOC_DAIFMT_NB_IF in the machine driver. When SND_SOC_DAIFMT_NB_NF
used, noise on Right channel.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
