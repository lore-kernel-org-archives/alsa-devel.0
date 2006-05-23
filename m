From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Re: mpu401_uart -how to set for output only?
Date: Tue, 23 May 2006 10:44:41 +0100
Message-ID: <200605231044.41691.gineera@aspect135.co.uk>
References: <200605191151.24428.gineera@aspect135.co.uk> <200605221418.51512.gineera@aspect135.co.uk> <s5hwtcekvkb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtcekvkb.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 22 May 2006 15:01, you wrote:
> At Mon, 22 May 2006 14:18:51 +0100,
>
> Alan Horstmann wrote:
> > Took a bit of effort to get patch to apply to 1.0.11 here, but eventually
> > suceeded to get it to compile and run, with MPU401_INFO_INTEGRATED in all
> > occurances.
> > Then changed ice1712.c 2nd port to MPU401_INFO_OUTPUT.  Loading the
> > driver failled:
> >
> >    linux kernel: ALSA ../../alsa-kernel/drivers/mpu401/mpu401_uart.c:548:
> > mpu401_uart: unable to grab port 0xc81c size 2
> >
> > Perhaps if ! ( _INTEGRATED) at this section should include _OUTPUT and
> > _INPUT flags?
>
> snd_mpu401_uart_new() assumes the full-duplex if neither OUTPUT nor
> INPUT flag is set.  It's just for convenience.
>
> The port allocation should have nothing to do with full or half
> duplex.  If the port is given and no INTEGRATED flag is set, the
> function tries to allocate the port.  The error message above means
> that the port is already allocated.
>
> You should set it "MPU401_INFO_OUTPUT | MPU401_INFO_INTEGRATED".

OK, I mis-understood how to use the flags.  That sorts out the error

> > cat /proc/asound/seq/clients
> >
> > Client info
> >   cur  clients : 3
> >   peak clients : 4
> >   max  clients : 192
> >
> > Client   0 : "System" [Kernel]
> >   Port   0 : "Timer" (Rwe-)
> >   Port   1 : "Announce" (R-e-)
> > Client  16 : "TerraTec DMX6Fire" [Kernel]
> >   Port   0 : "MIDI-Front DMX6fire 0" (RWeX)
> >   Port  32 : "Wavetable DMX6fire 0" (--e-)
> > Client  20 : "Aureal Vortex au8820" [Kernel]
> >   Port   0 : "au8820 MIDI 1" (RWeX)
> >
> > shows(?) that the wavetable device is not writable. aplaymidi cannot open
> > the port, and doesn't list it.
> >
> > Suggestions as to what causes this? Have checked out_enable=1,
> > input_enable=0 for the 2nd port.

This is just the same; the port has become not-writable (--e-)?  It was 
working duplex without _INFO_OUTPUT flag.

Thanks  Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
