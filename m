From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions [PATCH]]
Date: Tue, 8 Jul 2003 12:32:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030708173229.GG1030@dbz.icequake.net>
References: <20030707205357.GQ5013@dbz.icequake.net> <s5hsmphcmxu.wl@alsa2.suse.de> <20030708135821.GA1030@dbz.icequake.net> <s5hfzlhc4k5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hfzlhc4k5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

On Tue, Jul 08, 2003 at 07:27:06PM +0200, Takashi Iwai wrote:
> > The results are pasted below -- what is strange is that aplay identifies
> > the file as 11025Hz but apparently the OSS driver thinks it is 8000Hz
> > data.
>  
> ah, i understand.  you cannot cat to /dev/dsp in general.
> if you do this, it's supposed to be 8kHz mono samples.

Hmm, limitation of the ad1848 driver, of ALSA OSS emulation, or OSS API?

> > AD1848 goes into D0 for instance, and the suspend function does nothing
> > (since it is not a thinkpad), is the system still in an ok state as long
> > as the card's status is not set to D0 when the card is actually not in
> > D0?  Does that make sense?
> 
> if the chip supports really something the power management, we should
> implement it, too.  but AFAIK, ad1848 itself has no such a control.
> so, the suspend callback is expected just to save the last status so
> that it can be restored in the resume callback.

Ok, will see about doing that in some time.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
