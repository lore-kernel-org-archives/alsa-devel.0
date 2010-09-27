From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: how to mandate the use of PCM plugin?
Date: Mon, 27 Sep 2010 10:53:49 +0400
Message-ID: <4CA03F7D.8040602@aknet.ru>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru>
	<20100927055438.GA13129@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F3510384F
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 08:53:51 +0200 (CEST)
In-Reply-To: <20100927055438.GA13129@opensource.wolfsonmicro.com>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  27.09.2010 09:54, Mark Brown wrote:
> >  What I am trying to solve, is the problem
> >  that people have with my snd-pcsp driver.
> >  Pulseaudio uses "hw" to bypass some pcm
> >  plugins, and then people are left with the
> >  non-functional softvol control, and they blame
> >  my driver.
> >  I am looking for the way to mandate the
> >  softvol plugin even for the "hw" device.
> Why not work on fixing the actual problem if it's not already been
> fixed?
I am not sure what's the actual fix would
look like. I wasn't followed the alsa development
for a long time. Is there a way to consistently
replace the softvol controls? If so, then there is
a bug somewhere. Also, the snd-pcsp is configured
to use the "asym" plugin - I wonder if it is safe to
replace also that.
So the question is: can _all_ the plugins be safely
replaced by the software that opens "hw", or,
maybe, some are not, and then, they should be
somehow mandated?
>> Is this possible?
> No, and it would still be unhelpful since it would leave you with two
> soft volume controls in operation.
>
But this is not a real problem, this is the same
as if you have the volume control in the hardware.
You then also have 2 volume controls, or more.
And pulseaudio can just check whether or not
the volume control is present, and then simply not
to add its own. I dont think this is a real problem.
The real problem is when the mixer bar doesn't
work at all. :)
So what the real fix do you think of?
