From: Oliver Freyd <Oliver.Freyd@gmx.de>
Subject: Re: trident (Hoontech 4d Wave NX) dropouts with small buffersize.
Date: Fri, 8 Oct 2004 09:15:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041008071505.GA3394@gmx.de>
References: <20041005201351.GA25577@gmx.de> <s5hacuyu1b1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hacuyu1b1.wl@alsa2.suse.de>
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

Hello Takashi,

thanks for your reply!

On Thu, Oct 07, 2004 at 03:04:34PM +0200, Takashi Iwai wrote:
 
> No idea yet, but could you check whether this happens with ALSA native
> apps?  For example, you can run aplay with --buffer-size and
> --period-size options.  Pass above values to these options and see
> whether the playback works.
> 

Yes, I've tried that now, if play some sound with aplay, without
--buffer-size, it works normal. If I use --period-size 512 and
buffer-size 1024, I get that broken sound. Also with period-size 1024 and 
buffer-size 2048, I think. Only if I use a buffer-size > 2* period-size
if works ok.

> 
> > I'm running debian testing, 
> > alsa-source-1.0.5a-3
> 
> It's old :)
> 
This weekend I'll try to compile the newest alsa-sources :-)

Thanks for your help,

    Oliver



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
