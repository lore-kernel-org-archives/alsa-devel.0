From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH0/2] jack: Add support for SND_JACK_LINEOUT
Date: Tue, 21 Oct 2008 20:36:27 +0100
Message-ID: <20081021193626.GA6900@sirena.org.uk>
References: <48FCFAA8.8070005@embeddedalley.com>
	<20081021084806.GC10841@sirena.org.uk>
	<48FDF318.8050502@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43DCB24390
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 21:37:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FDF318.8050502@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 11:19:52AM -0400, Matthew Ranostay wrote:
> Mark Brown wrote:

> > or a microphone then there's no need for it - HEADSET is only provided
> > to make it more obvious how to implement one since people often don't
> > think of a headset as being its components.

> Actaully it's for the jack that has a mixer switch, in which the headphone
> support turned off and becoming a line out. I can understand not adding this,
> since only one codec patchset will probably use it.

What do you mean by a "mixer switch"?  Do you just mean a software
control that can select between line and headphone signals?  Is the
hardware able to determine which kind of device is connected to the
jack?
