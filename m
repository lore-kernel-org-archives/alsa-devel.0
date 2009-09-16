From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Can't resume from suspend because firmware is not
 found ?!?
Date: Thu, 17 Sep 2009 00:07:36 +0200
Message-ID: <20090917000736.606a8b8d@Jay>
References: <20090912223800.5170f488@Jay> <s5hk501lvav.wl%tiwai@suse.de>
	<20090916002742.212c08fc@Jay> <s5hd45rzb0f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id B3F2A244F3
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 00:08:17 +0200 (CEST)
In-Reply-To: <s5hd45rzb0f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Sep 2009 07:58:24 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > > You can't load the firmware file in resume phase because the system
> > > isn't yet ready at this stage.  Either postpone it or keep the old
> > > firmware and reuse it.
> >
> > *sigh*
> > Ok, I'll try to find a workaround. I don't want to keep the firmware in
> > memory.
>
> Is it so high volume?  This is the easiest solution in general.

16KB to 150KB, depending on the card. Most cards need more than one
firmware and some of them have to reload the firmware during mormal
operation, so I also have to write a very simple cache manager. If
possible, I would prefer not to waste that memory.


-- 
Giuliano.
