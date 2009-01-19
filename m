From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Patch] WM9705 tweak
Date: Mon, 19 Jan 2009 15:55:35 +0000
Message-ID: <20090119155534.GC22473@sirena.org.uk>
References: <49747F0E.6080600@mnementh.co.uk>
	<20090119133656.GB22473@sirena.org.uk>
	<49749D2C.3010003@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B44E12435F
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 16:55:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49749D2C.3010003@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2009 at 03:33:00PM +0000, Ian Molton wrote:
> Mark Brown wrote:

> >Are you absolutely sure that it doesn't get displayed at all?  Note
> >that the default display for alsamixer only shows controls it thinks
> >are playback controls, you need to use tab to change the view to show
> >other controls.

> I cant find the switch. I can see the capture control under the capture
> tab, but its mute isnt there.

I'm testing this with the WM9713 (which has "Capture Volume" and
"Capture Switch") and the control is visible.  It is presented
differently (as a capture facility switch which is toggled using space
rather than as a mute) but it's there.
