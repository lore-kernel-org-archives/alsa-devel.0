From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query about SNDRV_PCM_FORMAT_GSM
Date: Wed, 22 Jun 2011 12:58:33 +0100
Message-ID: <20110622115833.GA23666@sirena.org.uk>
References: <4E019C2F.1020007@codeaurora.org> <s5hsjr2198v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 307742466A
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 13:58:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsjr2198v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: waiw@codeaurora.org, asishb@codeaurora.org, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>, jaywang@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 11:54:56AM +0200, Takashi Iwai wrote:
> Patrick Lai wrote:

> > I see SNDRV_PCM_FORMAT_GSM is defined in asound.h. However, I do not
> > find any reference to this macro except pcm_misc.c. I am curious how
> > bps info(i.e 4.75 kbit/s) is passed down to the ALSA driver. Any
> > pointers?

> This is a vapor format until now, just reserved for the future
> implementation :)

It may make sense to handle this in a similar way to MP3s and so on -
the Intel guys were working on generalising the interface in their out
of tree driver to be usable for other things, though they've not posted
anything yet.
