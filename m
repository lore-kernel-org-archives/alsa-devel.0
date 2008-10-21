From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH2/2] hda: Add support for IDT codecs to
	report jack presence
Date: Tue, 21 Oct 2008 09:55:45 +0100
Message-ID: <20081021085543.GD10841@sirena.org.uk>
References: <48FCFAC6.8090407@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EC00F10380C
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 10:56:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FCFAC6.8090407@embeddedalley.com>
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

On Mon, Oct 20, 2008 at 05:40:22PM -0400, Matthew Ranostay wrote:
> Add support for reporting line out, headphone, and microphone jack insertions
> via the jack abstraction layer for the Sigmatel/IDT codec family.

The jack detection side of this looks good - I've not really reviewed
the HDA side of things.  One comment:

> +				if (type == SND_JACK_SWITCH)
> +					type = (pin_ctl & AC_PINCTL_HP_EN)
> +					? SND_JACK_HEADPHONE : SND_JACK_LINEOUT;

So SND_JACK_SWITCH is just a jack that can be either headphone or
lineout - like I said previously, you should not define a new jack type
for this but just set both jack types when registering the jack.
