From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: make ops a pointer in
	'struct	snd_soc_dai'
Date: Mon, 2 Mar 2009 11:50:49 +0000
Message-ID: <20090302115048.GB19744@sirena.org.uk>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C4BDD103846
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 12:50:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 02, 2009 at 11:25:46AM +0800, Eric Miao wrote:

> Considering the fact that most cpu_dai or codec_dai are using a same
> 'snd_soc_dai_ops' for several similar interfaces, 'ops' would be better
> made a pointer instead, to make sharing easier and code a bit cleaner.
> 
> The patch below is rather preliminary since the asoc tree is being
> actively developed, and this touches almost every piece of code,
> (and possibly many others in development need to be changed as
> well). Building of all codecs are OK, yet to every SoC, I didn't test
> that.

This is all fine, though I've not checked that everything was updated
yet.

> Signed-off-by: Eric Miao <eric.miao@marvell.com>

It looks like your mailer has mangled the patch somewhere - it appears
to have word wrapping damage.  Could you please resend?  As an
attachment is fine if your mailer is giving you too much trouble.

Please do remember to CC me on ASoC patches.
