From: "random.bits" <random.bits@rogers.com>
Subject: Re: Re: alsa driver, repeat playback of buffer contents
Date: Tue, 15 Mar 2005 13:49:02 -0500
Message-ID: <200503151349.02376.random.bits@rogers.com>
References: <200503141530.20339.random.bits@rogers.com> <200503142014.37841.mark@vuenyx.com> <Pine.LNX.4.58.0503150848280.1743@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0503150848280.1743@pnote.perex-int.cz>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I started to follow up on Jaroslav's  advice. 

I am opening the "hw" pcm device using snd_pcm_open in 
order to address the base hardware.

I use "snd_pcm_hw_params_get_buffer" to determine the 
buffer size (which I presume is the hardware ring 
buffer). If I map to this buffer and then fill it with 
the sound exactly, then commit it, it just plays once. 
I put my process into wait state by using sleep(1) 
calls. 
How can I get the hardware to continue to play using 
the data in the ring buffer?

Thanks,
Mark

On Tuesday 15 March 2005 02:49, Jaroslav Kysela wrote:
> On Mon, 14 Mar 2005, Mark Cannon wrote:
> > How can I send down a short PCM stream, and have
> > the hardware repeat it until told to stop?
>
> You must always copy the data to right place in the
> ring buffer unless the sound fragment has not exact
> (or multiple) size of ring buffer.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
