From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Dma query
Date: Wed, 25 Feb 2004 11:52:55 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402251141090.23913@denise.shiny.it>
References: <F509E6111989D311B63700805FA761DA09F28FEB@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F28FEB@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 25 Feb 2004, Gupta, Kshitij wrote:

> hi,
> 	I have a very trivial question about the dma transfers with respect
> to ALSA framework.
>
> Let me first explain a scenario
> We have a Circularly linked Buffer pool
>
> buf1    buf2    buf3     buf4  .... bufn
>
> In very simple terms playing an audio stream is reading from these buffers
> and continuously dma'ing it to the audio device (let's assume we have a read
> and write register with the audio device).  And in this circulary linked
> audio buffer the user fills the data and the driver empties it to the
> device.
>
> Now I am not able to fit this scenario in the ALSA framework.  I am
> referrring to alsa-kernel/arm/sa11xx-uda1341.c file as a reference for my
> driver.  And here I don't understand where do we specify the the exact dma
> parameters (like the start address of buffer and the destination address).

You should do most of the hw setup in the .hw_params callback. You get
pointers to the substream and hw_params structures and you have to setup
the hw and the buffer as requested. These macros may be useful
params_period_bytes(), params_buffer_bytes(), snd_pcm_substream_sgbuf(),
snd_sgbuf_get_addr(). There are many others, look at the sources :)


--
Giuliano.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
