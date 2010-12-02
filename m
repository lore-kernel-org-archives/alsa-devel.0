From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 1/2] ASoC: core: Reordered DAPM update power
	on widgets
Date: Thu, 2 Dec 2010 14:54:30 +0200
Message-ID: <201012021454.30943.peter.ujfalusi@nokia.com>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291291390-8669-2-git-send-email-peter.ujfalusi@nokia.com>
	<20101202122128.GA859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8206D103A71
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:54:38 +0100 (CET)
In-Reply-To: <20101202122128.GA859@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 02 December 2010 14:21:28 ext Mark Brown wrote:
> On Thu, Dec 02, 2010 at 02:03:09PM +0200, Peter Ujfalusi wrote:
> > +	unsigned int dapm_reorder_pupdate:1; /* Reordered pupdate in widgets =
*/
> =

> Please use a more meaningful name than pupdate, I can't parse what that
> stands for easily (I'm guessing power update?) and even with that it's
> not clear what the option actually does.

I'll try to figure out better name.

> =

> > +	unsigned int change, dapm_pupdate_first =3D 1;
> =

> Please split the new variable onto a separate line - mixed initialised
> and uninitialised variables are confusing to read.

True.
 =

> > -	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
> > -		if (val)
> > -			/* new connection */
> > -			connect =3D invert ? 0:1;
> > -		else
> > -			/* old connection must be powered down */
> > -			connect =3D invert ? 1:0;
> > +	change =3D snd_soc_test_bits(widget->codec, reg, val_mask, val);
> > +	if (val)
> > +		/* new connection */
> > +		connect =3D invert ? 0 : 1;
> > +	else
> > +		/* old connection must be powered down */
> =

> This is really confusing - if there's no change why are we not just
> exiting the function immediately?  It makes the rest of the code much
> harder to follow as the conditionals all get more complex.

Yes, in that case we do not even need the change variable, since if there i=
s no =

change I just: goto out;
Makes it cleaner.

Thanks,
P=E9ter
