From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: matrix mixer control (Re: Complex mixer questions)
Date: Mon, 31 Mar 2003 13:39:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303311307170.1602-100000@pnote.perex-int.cz>
References: <s5hznnbj47h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznnbj47h.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Mar 2003, Takashi Iwai wrote:

> i think it's good time to discuss this theme again.
> 
> as we talked in the LAD meeting, there are some possibilities:
> 
> 1. implement it on hwdep device
> 2. implement it as a new control element (e.g. CTL_ELEM_MATRIX)
> 3. introduce a flag to allow the indirect access with CTL_ELEM_INTEGER
> 4. use 1500+ mixer elements.
> 
> 
> we all agreed that really allocating thousands of elements is not
> clever.  so, the case 4 would introduce some "virtual" mapping in the
> kernel side, but from the user-space, it looks like a normal control
> API access.  however, this will need many changes in the alsa core
> code.
> 
> 
> OTOH, the case 1 would need no change for the alsa core itself, but
> the driver needs to implement by itself.  and above all, there is no
> notification mechanism.
> 
> the case 2 is, IMO, the most straightforward way.  the info field will
> have number of rows and columns, in addition to min, max and step
> values.  the change in the alsa core wouldn't be too much.

I think that we simply touch the barrier given by 'struct
sndrv_ctl_elem_id'. The identification which differentiate identical
controls is only the 'index' value. If we don't use 'struct
sndrv_ctl_elem_id' as the identification unit for read/writing of data,
then we end with trouble with notification and other representation
(single data unit locking, inactive flag etc). Imagine three or four
dimensional data types. Do you think that it's really worth to describe
these types? My original idea was to keep the control API as simple as
possible. The only one exception is the SNDRV_CTL_ELEM_TYPE_IEC958
structure but making more of those complicated data definitions seems to
be as a bad idea in my eyes.

The case 4) doesn't look as bad as it seems at first look. We do already 
have many controls in emu10k1 and trident drivers (route, pcm volumes 
etc.). If we optimize the memory usage and representation for these 
multiple identical controls, more drivers will benefit.

Note: Think in this way: If we have such large matrix mixer, then we
should allow to different applications sharing (lock -thus allocate- some
elements from matrix). Your suggested "solutions" (other than 4) don't
allow it fully. This might cause trouble in future.

> the case 3 would be similar with case 2, but use an additional bit
> flag to indicate the matrix type.

I don't understand. We have already SNDRV_CTL_ELEM_ACCESS_INDIRECT 
although it is not implemented. The problem here is that you will have 
totaly unoptimized event notification (because we can notify only change 
for whole row) and problematic sharing of single values (element locking).

> in the cases 2 and 3, you'll need to change alsactl to save/restore
> the whole matrix data.  in the case 4, it's not.  the case 1, alsactl
> cannot do it, since it's on hwdep device.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
