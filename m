From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Scatter Gather
Date: Tue, 2 Mar 2004 09:00:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403020859250.1995@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403010928390.5532-100000@studcom.urz.uni-halle.de>
 <1078200582.1446.21.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078200582.1446.21.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@mat.utfsm.cl>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Mar 2004, Manuel Jander wrote:

> By the way, is it really really necesary that "snd_pcm_period_elapsed()"
> is called exactly when one period has been playback ? Must that callback
> be called for every period ?
> After looking at the bt87x driver it seems that it doesn't matter after
> all (is that right ?). I was thinking in calling
> snd_pcm_period_elapsed() just after each page crossing, instead of
> period crossing, for simplicity.

It will create extra latency, because application will be woken up later
than expected. The driver should try to call this ack immediately when the
period transfer is finished.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
