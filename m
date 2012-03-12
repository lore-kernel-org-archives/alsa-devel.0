From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 1/4] add a mc13783 codec driver
Date: Mon, 12 Mar 2012 09:11:08 +0100
Message-ID: <1496586.ebXd01ibP4@laptop>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
	<20120311113848.GA3233@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp0.epfl.ch (smtp0.epfl.ch [128.178.224.219])
	by alsa0.perex.cz (Postfix) with SMTP id DC31D24353
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 09:11:17 +0100 (CET)
In-Reply-To: <20120311113848.GA3233@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: juergen.lambrecht@gmail.com, s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le dimanche 11 mars 2012 11:38:48 Mark Brown a =E9crit :
> On Fri, Mar 09, 2012 at 03:55:13PM +0100, Philippe R=E9tornaz wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > =

> > sha 20111307:
> > - rebased to 3.0-rc2
> > - implement tdm slot settings
> > - made it work with single ssi port
> > - more register names instead of hardcoded numbers
> > =

> > philippe 20120803:
> > - Add headset detection
> > - add mic2 bias
> > - enable headset output by default
> =

> If including stuff like this please include it after the ---.  Things
> like notes about the odd arrangements with the SSI ports which will have
> ongoing meaning are much more useful in the changelog.
> =

> Overall this looks fairly clean but very out of date, for example
> there's a custom register cache impelementation and no DAPM.

Thank you for this detailed review. I will redo the patch based on your =

comments. I had a quick look at DAPM (dapm.txt in asoc documentation), but =
is =

there any good "reference" implementation which is in the kernel where I co=
uld =

have a look ? =


Thanks,

Philippe
