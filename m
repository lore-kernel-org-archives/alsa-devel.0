From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: Configuring ALSA in kernel-2.5
Date: 27 Mar 2003 14:34:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048793663.2474.26.camel@tiger>
References: <1048788276.2474.3.camel@tiger>
	 <20030327190215.GA25637@www.angio.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030327190215.GA25637@www.angio.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Hassard <steve@hassard.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well that's my question. I'm running 2.5.66 on RH phoebe beta and need
to find out what to choose in the config. I have build a kernel with:

Advanced Linux Sound Architecture

<M> Advanced Linux Sound Architecture
<M>   Sequencer support
< >     Sequencer dummy client
[*]   OSS API emulation
<M>     OSS Mixer API
< >     OSS PCM (digital audio) API
[*]     OSS Sequencer API
<M>   RTC Timer support
[ ]   Verbose printk
[ ]   Debug

Generic devices

< > Dummy (/dev/null) soundcard
<M> Virtual MIDI soundcard
< > MOTU MidiTimePiece AV multiport MIDI
< > UART16550 - MIDI only driver
<M> Generic MPU-401 UART driver

PCI devices

< > ALi PCI Audio M5451
< > Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x
< > Cirrus Logic (Sound Fusion) CS4281
<M> EMU10K1 (SB Live! & Audigy, E-mu APS)
< > Korg 1212 IO
< > NeoMagic NM256AV/ZX
< > RME Digi32, 32/8, 32 PRO
< > RME Digi96, 96/8, 96/8 PRO
< > RME Digi9652 (Hammerfall)
< > RME Hammerfall DSP Audio
< > Trident 4D-Wave DX/NX; SiS 7018
< > Yamaha YMF724/740/744/754
< > Avance Logic ALS4000
< > C-Media 8738, 8338
< > (Creative) Ensoniq AudioPCI 1370
< > (Creative) Ensoniq AudioPCI 1371/1373
< > ESS ES1938/1946/1969 (Solo-1)
< > ESS ES1968/1978 (Maestro-1/2/2E)
< > ESS Allegro/Maestro3
< > ForteMedia FM801
< > ICEnsemble ICE1712 (Envy24)
< > ICE/VT1724 (Envy24HT)
< > Intel i8x0/MX440, SiS 7012; Ali 5455; NForce Audio; AMD768/8111
< > S3 SonicVibes
< > VIA 82C686A/B, 8233 South Bridge

ALSA USB devices

< > USB Audio/MIDI driver


These modules load ok when I modprobe. I think I have to install
alsa-libs and the oss compat lib? The kernel documentation should be
updated soon.

--Lou


 
 
On Thu, 2003-03-27 at 14:02, Stephen Hassard wrote:
> Hi Lou,
> 
> What modules do you have loaded?
> 
> What kernel version are you using?
> 
> Are you using devfsd?
> 
> later,
> Steve
> 
> On Thu, Mar 27, 2003 at 01:04:36PM -0500, Louis Garcia wrote:
> > The documentation in current 2.5 kernel is a bit out dated. Can someone
> > show me what modules to choose in order to sound working for a SB Live
> > card with oss emulation? I've tried several combos but can't get
> > /dev/mixer os /dev/sequencer going. After compiling kernel should I
> > compile alsa-libs then alsa-oss compat library?
> > 
> > --Lou
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by:
> > The Definitive IT and Networking Event. Be There!
> > NetWorld+Interop Las Vegas 2003 -- Register today!
> > http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
