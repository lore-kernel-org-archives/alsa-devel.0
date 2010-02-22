From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHES_v1] ASoC: Towards dropping runtime
	field	from snd_soc_dai
Date: Mon, 22 Feb 2010 14:27:49 +0000
Message-ID: <20100222142748.GB27789@sirena.org.uk>
References: <1b68c6791002212255j69faa9b7k13da803bf65c2177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D70D610383A
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 15:27:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002212255j69faa9b7k13da803bf65c2177@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 22, 2010 at 03:55:59PM +0900, jassi brar wrote:

I've applied all three changes for 2.6.35 after testing on an AT91 board
here, thanks.  Unfortunately it looks like the SSC suspend and resume
code is a bit broken anyway since it doesn't seem to cope too well with
being suspended during playback but your patches don't affect that one
way or another.

> <Due to some problem I am unable to send inline patches, please accept
> the attached patches for this time>

If you're going to do this please send just the patches as the
attachments, including the patch description in the attachment cases
them to come out like this:

    ASOC: ATMEL: Getting cpu_dai method change
    
    [PATCH 2/3] ASOC: ATMEL: Getting cpu_dai method change
    
    Currently only the atmel driver make use of snd_soc_dai.runtime field.

when applied which isn't ideal.  It also seems that your attachments are
coming out base64 encoded rather than text/plain.

> [PATCH 1/3] ASoC: PLATFORM: Pass dai_link as argument to suspend, resume
> [PATCH 2/3] ASOC: ATMEL: Getting cpu_dai method change
> [PATCH 3/3] ASOC: SND_SOC_DAI: Get rid of 'runtime' field

Note also the different spellings of ASoC here (and elsewhere in your
commit messages) - the first is correct.  You don't need to capitalise
all the letters in names.

If your problems are (as I'm guessing is the case) gmail breakage you
might want to look into imap-send, which will dump the patches in an
IMAP mailbox for transmission.
