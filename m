From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: USB audio devices
Date: Wed, 10 Mar 2004 10:08:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403101006120.28347@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403091851500.4549-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403091851500.4549-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Mar 2004, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
> 
> > On Tue, 9 Mar 2004, Takashi Iwai wrote:
> >
> > > BTW, the USB audio is another headache. the current ALSA PCM model isn't
> > > perfectly suitable for the devices like USB audio.
> >
> > Unfortunately I don't see a better model.
> 
> Conceptually, USB devices have variable-sized periods.  The question
> is whether we actually want to allow this in the API.  Probably not.

What this does mean? I though that the period size is specified with time 
(1ms) for USB, isn't it? I think that we can describe this constraint 
with the refine algorithm.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
