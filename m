From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Can't resume from suspend because firmware is not
 found ?!?
Date: Wed, 16 Sep 2009 00:27:42 +0200
Message-ID: <20090916002742.212c08fc@Jay>
References: <20090912223800.5170f488@Jay>
	<s5hk501lvav.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 563C124141
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 00:28:47 +0200 (CEST)
In-Reply-To: <s5hk501lvav.wl%tiwai@suse.de>
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

On Mon, 14 Sep 2009 11:39:20 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 12 Sep 2009 22:38:00 +0200,
> Giuliano Pochini wrote:
> > 
> > I tested suspend/resume on a laptop because I failed to make it work on my
> > G4 (grr!!). Suspend work, resume does not. From dmesg (below) it looks like
> > the soundcard driver is asked to resume before the ATA driver, thus is
> > cannot load the firmware. Am I overlooking something ?  Suggestions ?
> 
> You can't load the firmware file in resume phase because the system
> isn't yet ready at this stage.  Either postpone it or keep the old
> firmware and reuse it.

*sigh*
Ok, I'll try to find a workaround. I don't want to keep the firmware in
memory. Is there a way to know if resume is still in progress or when it is
possible to load the firmware ?  I could -as last resort- load the firmware
in the prepare callback.


-- 
Giuliano.dd
