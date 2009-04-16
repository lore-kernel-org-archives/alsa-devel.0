From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
 format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 14:35:24 +0300
Message-ID: <20090416143524.7b02fa5f.jarkko.nikula@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<200904151404.37003.peter.ujfalusi@nokia.com>
	<20090415115606.GB9311@sirena.org.uk>
	<dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
	<20090416101216.GI16318@sirena.org.uk>
	<dfeb90390904160317r1c1bfad0ndf2370120b18c8e1@mail.gmail.com>
	<20090416101945.GJ16318@sirena.org.uk>
	<20090416133143.10cbd1bf.jarkko.nikula@nokia.com>
	<20090416103358.GL16318@sirena.org.uk>
	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
	<dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EB20103999
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:34:40 +0200 (CEST)
In-Reply-To: <dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Arun KS <getarunks@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Apr 2009 13:20:36 +0200
ext Arun KS <getarunks@gmail.com> wrote:

> Hi Guys,
> 
> I had done some mistake while applying the Jarkko's patch previously.
> Now its working fine.
> Sorry for the confusion caused.
> 
Thanks for letting us know! We were privately discussing with Peter
that can there be some difference in OMAP1 causing this. Even McBSP is
quite compatible across different OMAPs there are some differencies
between them and those are not so easy to point out from number
different TRM's...


Jarkko
