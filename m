From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: au8830 - front / rear channels swapped after
	first play and Surround40
Date: Fri, 11 Mar 2005 09:58:06 -0300
Message-ID: <1110545886.3216.12.camel@localhost>
References: <42312D3F.2010201@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <42312D3F.2010201@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hi Raymond,

On Fri, 2005-03-11 at 13:31 +0800, Raymond wrote:
> When watching movie using gxine(xine-lib) downmix DVD sound to 
> Surround40, the human voice (Center) come out from rear speakers instead 
> of front on the second movie.
> 
> Turn off the Sigmatel STAC9708 stereo to 4 speakers and Sigmatel
> Surround Mix, Sigmatel 3D Surround using alsamixer.

I don't  understand. Are your recommending something or telling us what
you actually did ?

> 
> <confdir:pcm/front.conf>
> 
> AU8830.pcm.front.0 {
> 	@args [ CARD ]
> 	@args.CARD {
> 		type string
> 	}
> 	type hw
> 	card $CARD
> 	device 0
> }	
> 
> <confdir:pcm/surround40.conf>
> 
> AU8830.pcm.surround40.0 "cards.AU8830.pcm.front.0"
> 
> <confdir:pcm/iec958.conf>
> 
> AU8830.pcm.iec958.0 {
> 	@args [ CARD AES0 AES1 AES2 AES3 ]
> 	@args.CARD {
> 		type string
> 	}
> 	@args.AES0 {
> 		type integer
> 	}
> 	@args.AES1 {
> 		type integer
> 	}
> 	@args.AES2 {
> 		type integer
> 	}
> 	@args.AES3 {
> 		type integer
> 	}
> 	type hw
> 	card $CARD
> 	device 1
> }
> 
> 
> 1) Is this related to no cards.AU8830.pcm.rear in
> /usr/share/alsa/cards/AU8830.conf ?
> 
> I repeat the "aplay test" with out1lq.wav, out1rq.wav, out2lq.wav
> and out2rq.wav.
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59
> 
> Although there is a route left after snd_vortex_pcm_hw_free() when
> playing stereo sound (e.g. outls.wav and outrs.wav )
> 
> There is no swap of left/right channels on au8830.
> 
> The swapping of front/rear also occur when using speaker-test -c 4
> 
> 
> 2) Why "snd_vortex_pcm_hw_free()" is called twice by "aplay" ?

AFAIK, ALSA does not enforce that this function will be called only
once. It can be called multiple times, thus this is not something
strange.

> 3) Is the bug related to "vortex: IRQ fifo error" ?

No, thats not a bug. Thats normal.

> 4) Why some routes such as "ADBDMA(00) -> SRCIN(01)",
> "ADBDMA(00) -> SRCIN(02)", "ADBDMA(00) -> SRCIN(03)" are still exist
> after snd_vortex_pcm_hw_free ?

If the header entry of a set of routes, which are on the same bus is
missing, then all the other routes are disabled too. Routes that do not
have a header entry, are disabled.

> 5) What is the usage of Pre 3D/Post 3D setting in 'PCM Out Path & Mute' ?

Thats just a setting of the AC97 codec. It adds some cross mixture
between both stereo channels, but has nothing to do with real 3D sound.

> Need to understand the routes and mixin mixout setting before complete
> the au88x0_ac3_passthrough_spdif.patch.
> 
> 6) How to fill up the remain symbols in au8830_src[256] and
> au8830_dest[256] from OFFSET_???? from au8830.h ?
> 
> #define		OFFSET_ADBDMA	0x00
> #define		OFFSET_ADBDMAB	0x20
> #define		OFFSET_SRCIN	0x40
> #define		OFFSET_SRCOUT	0x20	/* ch 0x11 */
> #define		OFFSET_MIXIN	0x50	/* ch 0x11 */
> #define		OFFSET_MIXOUT	0x30	/* ch 0x11 */
> #define		OFFSET_CODECIN	0x70 /* ch 0x11 */	/* adb source */
> #define		OFFSET_CODECOUT	0x88 /* ch 0x11 */	/* adb target */
> #define		OFFSET_SPORTIN	0x78	/* ch 0x13 ADB source. 2 routes. */
> #define		OFFSET_SPORTOUT	0x90	/* ch 0x13 ADB sink. 2 routes. */
> #define		OFFSET_SPDIFIN	0x7A	/* ch 0x14 ADB source. */
> #define		OFFSET_SPDIFOUT	0x92	/* ch 0x14 ADB sink. */
> #define		OFFSET_AC98IN	0x7c	/* ch 0x14 ADB source. */
> #define		OFFSET_AC98OUT	0x94	/* ch 0x14 ADB sink. */
> #define		OFFSET_EQIN		0xa0	/* ch 0x11 */
> #define		OFFSET_EQOUT	0x7e /* ch 0x11 */	/* 2 routes on ch 0x11 */
> #define		OFFSET_A3DIN	0x70	/* ADB sink. */
> #define		OFFSET_A3DOUT	0xA6	/* ADB source. 2 routes per slice = 8 */
> #define		OFFSET_WT0		0x40	/* WT bank 0 output. 0x40 - 0x65 */
> #define		OFFSET_WT1		0x80	/* WT bank 1 output. 0x80 - 0xA5 */
> /* WT sources offset : 0x00-0x1f Direct stream. */
> /* WT sources offset : 0x20-0x25 Mixed Output. */
> #define		OFFSET_XTALKOUT	0x66	/* crosstalk canceller (source) 2 routes */
> #define		OFFSET_XTALKIN	0x96	/* crosstalk canceller (sink). 10 routes */
> #define		OFFSET_EFXOUT	0x68	/* ADB source. 8 routes. */
> #define		OFFSET_EFXIN	0x80	/* ADB sink. 8 routes. */

There are many Route sources or targets that are either unused or just
not documented. Since aureal did never release ant documentation, you
guess it, we will never know. By the way, there are no 256 source/target
pairs. The number of sources and target are different for each breed of
aureal chip, and not powers of 2.

Take a look at
http://galadriel.mat.utfsm.cl/~mjander/aureal/techdoc/techpaper.html
and au8830.pdf in the same folder.

> 7) Can anyone explain how the adddress of audio data pass to DMA
> registers in the current alsa driver code ?
> 
> I try to log the hwread() and hwwrite(), but dmesg cannot show all entries.

You should rather take attention on the vortex_connect_* functions
inside of au88x0_core.c instead at register level. The only thing you
have to taake care about is that if you make a route, that both, the
source and the target are enabled, providing and consuming data
respectively.

> 8) How to to obtain a full log ?

Hmm that could be rather difficult. Why don't you just add some printk
hooks into vortex_route* functions (au88x0_core.c) ? That would be a lot
easier and you get the really relevant information.

> Please note that I have disabled some default routes in
> vortex_connect_default()
> 
> //	vortex_wt_connect(vortex, en);
> //	vortex_Vort3D_connect(vortex, en);
> 
> 
> This following is the result of "aplay out1lq.wav".
> 
> # /etc/init.d/alsasound stop
> # /etc/init.d/alsasound start
> # dmesg
> 
> Vortex: init.... <6>done.
> input0: Analog 4-axis 4-button joystick at gameport0.0 [ADC port]
> Routes After vortex_connect_default()-----------
> 00028140 : 00007151   CODECIN(1) -> MIXIN(01)
> 00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
> 00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
> 00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
> 00028234 : 00007050   CODECIN(0) -> MIXIN(00)
> 00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
> 00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
> 00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
> 000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
> 00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
> ----------------------------------------
> MIXIN_MIXOUT ENABLE
> ----------------------------------------
> 
[snip!]


Best Regards,
--
Manuel Jander
Electronic Engineer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
