From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5B2=2E6=2E30-rc2=5D=5BPATCH_1/2=5D_A?=
 =?iso-8859-1?q?SoC=3A_OMAP=3A_Fix_DSP=5FB_format_=09in_OMAP_McBSP_DAI_dri?=
 =?iso-8859-1?q?ver?=
Date: Thu, 16 Apr 2009 13:36:06 +0300
Message-ID: <200904161336.07012.peter.ujfalusi@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<20090416101216.GI16318@sirena.org.uk>
	<dfeb90390904160317r1c1bfad0ndf2370120b18c8e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FF6410396C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:36:16 +0200 (CEST)
In-Reply-To: <dfeb90390904160317r1c1bfad0ndf2370120b18c8e1@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 16 April 2009 13:17:03 ext Arun KS wrote:
> On Thu, Apr 16, 2009 at 3:42 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> > On Thu, Apr 16, 2009 at 03:38:07PM +0530, Arun KS wrote:
> >> This patch is working(tested on osk5912), but with
> >> SND_SOC_DAIFMT_NB_IF in the machine driver. When SND_SOC_DAIFMT_NB_NF
> >> used, noise on Right channel.
> >
> > What sort of noise are you getting - is it just noise or is there some
> > signal underneath the noise?  Can you try playing a signal with no data
> > on the left channel and see what effect that has?
>
> Its not just noise, signal is there underneath.

Do you have Jarkko's two patches only? Can you give a try to my two patches=
 on =

top of that? Can be the problem in the dual/single phase mode?

>
> > The CODEC doesn't support inverted frame so a configuration with
> > inverted frame clock can't be correct.

-- =

P=E9ter
