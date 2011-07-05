From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Tue, 5 Jul 2011 12:37:11 -0700
Message-ID: <20110705193711.GB8642@opensource.wolfsonmicro.com>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
	<1309762610.15931.119.camel@matrix>
	<20110704223419.GA1030@opensource.wolfsonmicro.com>
	<1309875922.15931.169.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3CB3244CF
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 21:37:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309875922.15931.169.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 05, 2011 at 07:55:22PM +0530, Ashish Chavan wrote:
> On Tue, 2011-07-05 at 04:04 +0530, Mark Brown wrote:

> > | You'd need to implement custom controls for the relevant enables which
> > | check to see what is currently enabled and prevents enables if there
> > | are conflicts.  You should do this dynamically and I'd expect that only

> Yes, I got what you meant here and after some homework also found the
> example of this. You are trying to convey something similar to what is
> done within "outmixer_event()" function of sound/soc/codecs/wm8991.c (at
> lest the condition checking part), right?

No, that's not a user visible control that's part of the internal DAPM
power management stuff.  You're looking for struct snd_kcontrol_new
stuff.

> > All you're doing is trying to restrict the values that can be set on a
> > control dynamically.

> I think, it is more about restricting access to a set of controls
> dynamically based of enable/disable of some other control(s).

The state of another control is one example of a dynamic source of
information.
