From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 12:43:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406071239110.3294@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de>
 <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com>
 <20040607111729.A23059@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040607111729.A23059@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: Roc Wu <cooloney@yahoo.com.cn>, Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Jun 2004, Russell King wrote:

> Actually, I disagree.  It's an ALSA bug.  The warning is created if
> the AACI close method is called while the DMA or IO is still running.
> If DMA is still running here, we've already freed the DMA buffer, so
> we're either reading from or writing to memory we don't own - which is
> a major bug.
> 
> The question is therefore: why is ALSA trying to shut down and free a
> device which still has DMA running?  To be more explicit, why didn't
> ALSA call the trigger callback with SNDRV_PCM_TRIGGER_STOP prior to
> calling the hw_free or close methods?

The midlevel calls *drop() (which must stop the running stream) and then
->hw_free and ->close callbacks. I've never seen this error, so I suspect
that something else is wrong.

Could you track why snd_pcm_playback_drop() call fails in 
snd_pcm_release() for this hardware?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
