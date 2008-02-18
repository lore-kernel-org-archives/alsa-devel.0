From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 14:36:55 +0000
Message-ID: <20080218143655.GE21314@rakim.wolfsonmicro.main>
References: <1203344273.4063.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0B911038F9
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 15:36:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203344273.4063.6.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 08:17:53AM -0600, Brian Austin wrote:

> I have a codec I would like to submit.  The Cirrus Logic CS42L52 Low
> Power codec.  I have the codec code as well as the machine code for the
> Cirrus Logic EP9407A, but cannot submit that yet.  Is it OK to just
> submit the codec code for now?  This does not use the new API, so a hint
> as to which tree to make the diff from would help.

Assuming that this is an ASoC codec driver please go ahead and submit
the codec by itself - there's no requirement for an in-tree machine
driver.  For ASoC v1 a patch against any of current alsa-driver hg,
Linus' current kernel or the dev branch of the ASoC repository at
git://opensource.wolfsonmicro.com/linux-2.6-asoc should be fine -
whichever you find most convenient.
