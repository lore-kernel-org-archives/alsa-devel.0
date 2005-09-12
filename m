From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: [conf patch] modem's pcm "two device" config [was: Re: Mo' better modem support]
Date: Tue, 13 Sep 2005 01:10:18 +0300
Message-ID: <20050912221018.GA19713@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de> <20050907160343.GA3375@sashak.softier1.local> <20050912002746.GA31233@tecr> <s5hzmqih8q2.wl%tiwai@suse.de> <s5hzmqifa6e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzmqifa6e.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 19:49 Mon 12 Sep     , Takashi Iwai wrote:
> > 
> > Applied.  Thanks.
> 
> Well, I found that this might not work (still not tested, though)
> since the controls are usually defined with index 1, as noted in my
> earlier post.  (It's because the modem codec is in ac97.num=1)

And card index is usually 1 as well (first card is excluded in drivers).

Sasha.

> 
> But I think we should fix the driver side rather than this
> configuration.  The index should be zero because it's the only one.
> 
> 
> Takashi
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
