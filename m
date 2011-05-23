From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA and MediaController
Date: Mon, 23 May 2011 16:00:11 +0100
Message-ID: <20110523150011.GA6489@sirena.org.uk>
References: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
	<BANLkTikTO64=LWWvwSPM=3uAW_CHNbMDNQ@mail.gmail.com>
	<20110521105732.GA10004@sirena.org.uk>
	<BANLkTinyHbZWHUwEK0D4w1xrmKyLXRH-2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA10D1037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 17:00:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinyHbZWHUwEK0D4w1xrmKyLXRH-2w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2011 at 01:39:08PM +0800, Raymond Yau wrote:
> 2011/5/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:

I see you've ignored my remarks about CCing people and managed to cut
that text without also deleting other unneeded context; please do CC
people, it is actually important if you want people to engage in
discussion.

> But snd_jack API seem does not has any definition for "Line In" - Blue jacks ?

I don't see any substantial issue with adding such a definition if
someone has use for it?

> The jack retasking is performed by snd_hda_sequence_write_cache(codec,
> chmode[mode].sequence) in snd_hda_ch_mode_put() for some HDA codecs

I'm not sure what the point you're trying to make here is - the
internals of individual drivers shouldn't be too relevant to external
interfaces?
