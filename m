From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ctl api questions
Date: Tue, 11 Mar 2003 14:16:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111409430.2651-100000@pnote.perex-int.cz>
References: <1047373458.1906.13.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1047373458.1906.13.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11 Mar 2003, Thomas Charbonnel wrote:

> Hi,
> 
> As you may know the hdsp has a variable number of channels depending on
> the sample rate. The card's internal routing is controlled by a matrix
> mixer. For convenience simple mixer ctls are defined at card
> initialization. When the number of channels change, I flag the .access
> field of the unused ctls with SNDRV_CTL_ELEM_READ and
> SNDRV_CTL_ELEM_INACTIVE. It seems to work fine with amixer (amixer
> controls doesn't show anymore the unused channels), but alsamixer gives
> the following error: function snd_mixer_load failed: Invalid argument.
> Any idea on what is going wrong ? 

I don't know. Could you try to test this behaviour with the dummy driver 
(add the same controls as present in HDSP). We can debug then the user 
space problems.

> Another point: the matrix mixer is now (with patch II from Paul)
> read/write. In write mode it takes 3 parameters:
> source,destination,gain. With the amixer patch I submitted some days ago
> it is possible to actually read it, passing source and destination
> channels as parameters to the cget option. In the driver, the return
> values use the same structure as the parameters. Should I respect the
> parameters index (returning the gain value in value[2]) or should I
> consider that return values start at value[0] ?

Note that this behaviour is non-standard. You simply moved the addressing 
outside the sndrv_ctl_elem_id structure which is quite bad in the sense of 
common API. I think that it would be nice to invent some group controls 
represented inside the kernel space only with one structure rather than 
doing things which doesn't follow the API design.

For example, alsactl doesn't know about your addresing thus is impossible 
to save and restore the settings of this card via this universal utility.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
