From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 10:09:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507281009010.8458@tm8103.perex-int.cz>
References: <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Giuliano Pochini <pochini@shiny.it>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Jul 2005, Clemens Ladisch wrote:

> > I believe PCM iface attribute could be used for such a purpose,
> 
> As far as I see, the iface/device/subdevice fields were designed for
> exactly this purpose, i.e., associating a control with a specific
> (sub)device.
> 
> > but unfortunately, the situation is confusing.  Some drivers
> > already use PCM iface for different purposes (e.g. hdsp) and some
> > use mixer iface for exactly this purpose (e.g. emu10k1)...
> 
> Then I'd consider these drivers buggy.

I agree.

> I'll write a patch unless anybody objects ...

No objections from my side.

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
