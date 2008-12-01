From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Add pre-DAC digital mux
	controls
Date: Mon, 1 Dec 2008 14:18:23 +0200
Message-ID: <200812011418.23143.peter.ujfalusi@nokia.com>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-5-git-send-email-peter.ujfalusi@nokia.com>
	<20081201114348.GD13758@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E9432444B
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 13:18:56 +0100 (CET)
In-Reply-To: <20081201114348.GD13758@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Monday 01 December 2008 13:43:48 ext Mark Brown wrote:
> On Mon, Dec 01, 2008 at 10:03:48AM +0200, Peter Ujfalusi wrote:
> =

> > Controls for selecting the digital inputs for the four
> > DAC.
> =

> How often is this feature used at the minute?  While I've got no problem
> with the code per se there's currently no framework in ASoC for handling
> digital routing which means that having the flexibility creates problems
> with DAPM (which isn't implemented yet for this codec).  There's no real
> issue merging it, but it might make life easier to leave it for now.

One thing came to my mind for the use of this:
In theory, if the TWL is running in TDM (4 channel audio mode), your board =
file
sets the initial routing for all four channel. But at some point you want t=
o route
mono audio to the earpiece out from the SDRL2 and SDRR2, leaving the SDRL1 =
and SDRR1
routings same... Or something like this.
I'm not a good 'let's define some good use case scenario' type of guy...

> =

> Implementing digial routing support is on my radar but it's firmly below
> the V2 merge.
> =



-- =

P=E9ter
