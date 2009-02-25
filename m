From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 11:57:32 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0902251153370.1596@tm8103.perex-int.cz>
References: <s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<s5h8wnvreab.wl%tiwai@suse.de>
	<20090224184604.GA2253@tango.0pointer.de>
	<s5hocwr64pz.wl%tiwai@suse.de>
	<20090224192611.GC2253@tango.0pointer.de>
	<20090224211621.GA25412@tango.0pointer.de>
	<s5hd4d6pzak.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 788372444A
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 11:57:33 +0100 (CET)
In-Reply-To: <s5hd4d6pzak.wl%tiwai@suse.de>
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

On Wed, 25 Feb 2009, Takashi Iwai wrote:

> Anyway, the definitions of delay and avail in a free-wheel mode are
> ambiguous and rather confusing indeed...

I don't agree. We manage appl_ptr also in no-XRUN check mode for ALSA 
apps, so the negative values makes sense and applications can quickly 
skip missed samples (snd_pcm_forward).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
