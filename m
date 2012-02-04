From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack detection on HDA vs SoC
Date: Sat, 4 Feb 2012 13:20:29 +0000
Message-ID: <20120204132029.GA7438@sirena.org.uk>
References: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D4C4243B5
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 14:20:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 03, 2012 at 06:01:41PM -0800, Dylan Reid wrote:

You're more likely to get responses to mails if you CC maintainers.

> Is there a plan for the soc code to use the control-based method?

Not exactly.  I'm expecting that the new interface will be integrated
into the generic ALSA jack support rather than done as a custom thing in
the HDA drivers which will mean that anything supporting accessory
detect will get support, including ASoC.  This stuff should really be
handled in the core rather than in individual drivers, there's also
extcon which we'll need to integrate with.

> Is there a consensus on whether new drivers should auto-switch or not?

For embedded systems they definitely should not, it's frequently
inappropriate (the most common case is things like ringtones which many
userspaces think should always play to speaker so people can hear them
even if they have removed their headphones).  I think the consensus was
to move the PC audio to supporting runtime switching between the two
modes so that if PulseAudio or whatever userspace sound manager is there
wants to it can take control and do the switching for cases like the
above.
