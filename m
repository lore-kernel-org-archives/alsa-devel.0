From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 10:34:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507281032400.8458@tm8103.perex-int.cz>
References: <s5hll3slj32.wl%tiwai@suse.de>
 <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
 <42E889DD.2070808@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E889DD.2070808@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jul 2005, Raymond wrote:

> In theory, and sound cards with hardware mixing can support this kind of
> volume control.
> 
> au88x0 driver may provide this kind of volume control on playing PCM
> streams by using hardware mixers.
> 
> However the hardware mixers are dynamically allocated in routine
> snd_vortex_pcm_hw_params(), this means that the kcontrol can be put/get
> only between snd_pcm_hw_params() (return no error) and
> snd_pcm_hw_free()/snd_pcm_close().

Nope. Please, define the controls at the driver initialization phase and 
make them inactive when the stream is not open. See emu10k1 or trident 
driver for hints. You must also map the voice volume with substream 
number.

Creating controls dymanically has only sense when hardware changes (like a 
new DSP is loaded for emu10k1).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
