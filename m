From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 10:56:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507281053400.8458@tm8103.perex-int.cz>
References: <Pine.HPX.4.33n.0507280926040.9785-100000@studcom.urz.uni-halle.de>
 <Pine.LNX.4.61.0507281030580.8458@tm8103.perex-int.cz> <s5hll3rtjd8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll3rtjd8.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Giuliano Pochini <pochini@denise.shiny.it>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jul 2005, Takashi Iwai wrote:

> At Thu, 28 Jul 2005 10:32:33 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Thu, 28 Jul 2005, Clemens Ladisch wrote:
> > 
> > > As far as I can see, no driver actually uses the subdevice (substream)
> > > field for PCM substreams; probably because this would require a
> > > separate control for each substream instead of using an array.
> > 
> > See emu10k1, trident .... They define controls in this way, but the 
> > interface is set to MIXER (and should be really changed to PCM).
> 
> IIRC, they use the index field, not subdevice.

Yep, sorry. Of course, it's time to change (and add a new flag for 
snd_ctl_new1() which will change semantics for snd_kcontrol_new_t->count 
member from index to subdevice).

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
