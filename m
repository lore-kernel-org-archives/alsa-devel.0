From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: BLOCK_TRANSFER flag in snd_pcm_hardware_t structure
Date: Wed, 19 Feb 2003 22:48:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302192240300.13349-100000@pnote.perex-int.cz>
References: <08F1D234AF91E540BC1F43889E2A6AA70AEC08@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <08F1D234AF91E540BC1F43889E2A6AA70AEC08@digiexch.digigram.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marc Titinger <titinger@digigram.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Feb 2003, Marc Titinger wrote:

> Hi All,
> 
> I can't figure out from the code what are the implications of having the flag SNDRV_PCM_INFO_BLOCK_TRANSFER set in a snd_pcm_hardware_t.info field ?
> is this flag linked to the values of .period_bytes_min/max or .fifo_size ?
> is this related to the hw_ptr granularity ?

It's not related to anything which application can determine. Please, 
don't rely so much on this flag. It is not well defined.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
