From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions [PATCH]]
Date: Tue, 8 Jul 2003 14:54:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030708195437.GL1030@dbz.icequake.net>
References: <20030708173229.GG1030@dbz.icequake.net> <s5hd6gkdimp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd6gkdimp.wl@alsa2.suse.de>
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

On Tue, Jul 08, 2003 at 07:37:50PM +0200, Takashi Iwai wrote:
> > On Tue, Jul 08, 2003 at 07:27:06PM +0200, Takashi Iwai wrote:
> > > > The results are pasted below -- what is strange is that aplay identifies
> > > > the file as 11025Hz but apparently the OSS driver thinks it is 8000Hz
> > > > data.
> > >  
> > > ah, i understand.  you cannot cat to /dev/dsp in general.
> > > if you do this, it's supposed to be 8kHz mono samples.
> > 
> > Hmm, limitation of the ad1848 driver, of ALSA OSS emulation, or OSS API?
> 
> IIRC, it's the definition of this OSS device.
> well, i'm not sure this is officially so.
> but at least, /dev/audio is supposed to be in these formats, and we
> initialize /dev/dsp as well.
> 
> btw, for testing the OSS emulation, you can try play command included
> in sox package.

You are correct, play works correctly but catting does not.  It seems,
however, that many OSS drivers support cat a wav file directly to /dev/dsp,
and do the detection of the format parameters internally.  I guess this is not
required by the OSS specification?

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
