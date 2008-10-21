From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH2/4] hda: dynamic jack id
Date: Tue, 21 Oct 2008 20:41:37 +0100
Message-ID: <20081021194137.GC6900@sirena.org.uk>
References: <48FE10D8.4020307@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 54878243A2
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 21:42:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FE10D8.4020307@embeddedalley.com>
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

On Tue, Oct 21, 2008 at 01:26:48PM -0400, Matthew Ranostay wrote:
> Allow jack->id to be kstrdup()'ed to prevent scope issues from
> calling functions.

Your patch doesn't allow it to be duplicated - it does actually
duplicate it.  Do you mean to say that you want to duplicate the string
so that users can automatically generate the string without having to
manage the memory for it?

That should be OK for the embedded case, the size of the string isn't
such a big deal if you're able to handle a reasonable amount of audio
data, and it's probably going to be a common case with autoprobable
things like HDA.

I'd prefer a clearer changelog but:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
