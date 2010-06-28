From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
 snd_pcm_read/write()
Date: Mon, 28 Jun 2010 09:47:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006280946260.15497@eeebox2.perex-int.cz>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E902C1038E6
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 09:47:10 +0200 (CEST)
In-Reply-To: <1277590400.2438.15.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Sat, 26 Jun 2010, David Dillow wrote:

> When using poll() to wait for the next period -- or avail_min samples --
> one gets a consistent delay for each system call that is usually just a
> little short of the selected period time. However, When using
> snd_pcm_read/write(), one gets a jittery delay that alternates between
> less than a millisecond and approximately two period times. This is
> caused by snd_pcm_lib_{read,write}1() transferring any available samples
> to the user's buffer and adjusting the application pointer prior to
> sleeping to the end of the current period. When the next period
> interrupt occurs, there is then less than avail_min samples remaining to
> be transferred in the period, so we end up sleeping until a second
> period occurs.
>
> This is solved by using runtime->twake as the number of samples needed
> for a wakeup in addition to selecting the proper wait queue to wake in
> snd_pcm_update_state(). This requires twake to be non-zero when used
> by snd_pcm_lib_{read,write}1() even if avail_min is zero.
>
> Signed-off-by: Dave Dillow <dave@thedillows.org>

Thanks. It looks like another way to get things right. I applied your 
patch to my tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
