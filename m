From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] ASoC: Blackfin I2S: Setting the TFS
	pin	selector for SPORT 0 based on whether the selected port
	id F or G.
Date: Tue, 21 Oct 2008 09:41:16 +0100
Message-ID: <20081021084113.GB10841@sirena.org.uk>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
	<1224560173-8728-4-git-send-email-cooloney@kernel.org>
	<s5hy70i8nag.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 59244103905
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 10:41:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy70i8nag.wl%tiwai@suse.de>
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
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 08:39:19AM +0200, Takashi Iwai wrote:
> At Tue, 21 Oct 2008 11:36:13 +0800,
> Bryan Wu wrote:

> > From: Cliff Cai <cliff.cai@analog.com>

> > Also include some small coding style cleanup.

> Try checkpatch.pl to make sure that you really cleaned up, not added
> new warnings :)

Also, your Subject: should probably be moved in here and a shorter
version used for the Subject: line.  In general the entire subject line
should be shorter than 80 columns otherwise it doesn't work too well
when viewing the logs.
