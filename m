From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: [Openvortex-dev] Re: au88x0 - Replace spdif frequency control
 by IEC958 control
Date: Tue, 01 Mar 2005 11:09:42 -0300
Message-ID: <1109686182.3296.19.camel@localhost>
References: <42246DB6.5040608@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <42246DB6.5040608@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, openvortex-dev <openvortex-dev@nongnu.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, 2005-03-01 at 21:27 +0800, Raymond wrote:
>  >> The parameter 'spdif_mode' in the routine
>  >> vortex_spdif_init(vortex,spdif_sr,spdif_mode) in au88x0_core.c seems
>  >> to control AC3 passthrough.
>  >>
>  >> However the two memory mapped I/O VORTEX_SPDIF_CFG0 and
>  >> VORTEX_SPDIF_CFG1 seem to be write-only, return zero when read.
> 
>  >Then we need to cache the values.

Just as we currently do with many other registers :)

> Define snd_aes_iec958_t spdif_out in struct snd_vortex in au88x0.h
> 
[snip!]

> http://lists.gnu.org/archive/html/openvortex-dev/2003-11/msg00008.html
> 
> 3) Do we need to change the ADB routing when using AC3 passthrough ?

Hmm, good question. Maybe yes, because the current SPDIF PCM device
route does stereo deinterlacing (separating two stereo channels). The
SPDIF interface has 2 input sinks. For AC3 data, 2 interlaced channels
does not make ant sense, because it could be 4, 6 or more, encoded in
who knows what. Its just some raw data that must be passed through
intact. It may be that in AC3 passthrough mode the SPDIF transmitter
just re-joins the 2 data streams resulting in the original raw bit
stream, hopefuly not messing it up. Maybe someone with more SPDIF
knowledge can comment on this ?

> >
> > > 5) What additional kcontrol and routine are needed for SPDIF IN ?
> >

AFAIK, there is no direct SPDIF input interface on the au8830 chip. It
looks like that the SPDIF input is implemented using a I2S port or one
of the coporecessor interfaces. Since they are all sincronous serial
interfaces, they probably are almost the same and almost compatible
between each other, requiring little tweaking/additional circuitry on
the interface daughter-board.

> 5) How can STAC9721 stereo codec provide quad audio ? ( Is it through
> SPDIF-I2S link ? )

That depends on the hardware. AFAIK, the STAC9721 supports only 2
channels. If we want 4, then obviously, the other two must go through
any other codec. It could be a secondary STAC9721, a I2S codec connected
to the I2S interface, some other kind of codec/DSP connected to any of
the 8 coprocessor I/O interfaces, SPDIF, or whatever interfaces there
might be we don't even know about.

Best Regards
-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
