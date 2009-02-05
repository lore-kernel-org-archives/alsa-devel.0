From: Michael Schwingen <rincewind@discworld.dascon.de>
Subject: Re: PATCH: Maxdata Favorit 100XS support
Date: Thu, 5 Feb 2009 09:36:48 +0100
Message-ID: <20090205083648.GA17506@a-tuin.dascon.de>
References: <20090201193039.GA24196@discworld.dascon.de>
	<s5htz797365.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dascon.de (polyphem.dascon.de [212.117.81.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 7272F1038B8
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 09:42:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htz797365.wl%tiwai@suse.de>
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
Cc: Michael Schwingen <michael@schwingen.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2009 at 08:28:50AM +0100, Takashi Iwai wrote:
> The patch looks almost good but there are a few issues to fix.
> 
> First off, please use a unified diff (diff -u) for a patch.
> Then, rebase your patch to the latest sound git tree[*] or 2.6.29-rc3 
> at least.
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> Some stuff in patch_realtek.c in the latest tree was changed to be
> incompatible from 2.6.28.  For example,

OK.

> Don't you use alc260_favorit100_init_verbs?

I intended to - probably some last-minute error when cleaning up for the
diff.

> Could you fix these and repost?

Sure. It might take some days.

cu
Michael
