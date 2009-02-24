From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Timer instability
Date: Tue, 24 Feb 2009 20:04:23 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0902242002560.1596@tm8103.perex-int.cz>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<s5h8wnvreab.wl%tiwai@suse.de>
	<20090224184604.GA2253@tango.0pointer.de>
	<s5hocwr64pz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DADCC1037F6
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 20:04:23 +0100 (CET)
In-Reply-To: <s5hocwr64pz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Feb 2009, Takashi Iwai wrote:

> > In reality this setting should not matter at all, because most machines
> > should be fast enough to keep the buffer filled even if we write one
> > sample at a time as it is done in the example.
> 
> Not really.  If you feed the output to a terminal, it's damn slow.
> That's why I got XRUN.

I figured this few seconds ago, too. It's the terminal output which 
makes XRUN.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
