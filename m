From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Tue, 12 May 2009 10:21:05 +0100
Message-ID: <20090512092105.GD29889@sirena.org.uk>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
	<ad2655cb0905120047g69887a4bg5e0794bbd21eac27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 122D6103831
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 11:21:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ad2655cb0905120047g69887a4bg5e0794bbd21eac27@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 08:47:31AM +0100, James Courtier-Dutton wrote:

> Once we have the global definition, we can then fix each driver to
> comply with it. In some cases we will have to add virtual controls.

...

> I personally think that the user should set the global speaker
> settings, the master, front, rear etc. controls and then just leave
> them.
> I think applications should only control their own PCM channel volume,
> and not touch the master volume at all. PA could then further control
> PCM channel volumes, by for example automatically attenuating the
> sound of an application when it gets put in the backround, if the user

This is starting to sound a lot like the stuff that's been talked about
for the scenario API in an embedded context - it has a similar idea of
having a central application managing the overall setup of the card and
giving applications something simpler to work with:

	http://www.slimlogic.co.uk/?p=40

We don't want to force the use of per-application volume since that will
be too expensive for some systems, but a system that arranges for there
to be a standard control that the application should use for things like
master volume can support either a per-application control or using the
hardware control directly.

It's not always going to be possible to provide a fixed setup in the
driver since in systems like smartphones the arrangement of controls can
change very substantially depending on software controlled 
