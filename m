From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: VT8233/A/8235 Clock Problem - good results, some possible bugs?
Date: Tue, 9 Dec 2003 13:21:25 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031209102125.GB835@master.mivlgu.local>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de> <1070914615.1921.24.camel@Wizard.knechthome.com> <20031208210455.GF1802@sirius.home> <1070942917.1981.67.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1070942917.1981.67.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2003 at 08:08:37PM -0800, Mark Knecht wrote:
> On Mon, 2003-12-08 at 13:04, Sergey Vlasov wrote:
> 
> > Most likely you need the dxs_support option instead of ac97_clock.
> > 
> > With dxs_support=2 the sound should work fine, but the hardware mixing
> > capability will be disabled.  Then you can try dxs_support=1 or
> > dxs_support=4.
> > 
> > By default snd-via82xx uses dxs_support=3 (except for certain known
> > motherboards), this makes only 48000 sampling rate available.  The
> > ALSA library can perform resampling for ALSA apps, and the kernel OSS
> > emulation layer can do resampling for OSS apps, but the quality is
> > often not good.
> 
> Sergey,
>    Thanks for sending me down this path. Definitely I'm getting better
> results now. I did find some things out though. Some may possibly be
> bugs:
> 
> 1) On my system dxs_support=3 is NOT the same as not setting dxs_support
> at all. With dxs_support not set I get horrible results. With
> dxs_support=3 I get reasonable to good results.

This means that you board in known to the driver...

There is an entry for a similar model in the driver:

	{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_ENABLE }, /* Gigabyte GA-7VAXP */

The IDs checked here are the PCI subsystem vendor/device ID of the sound
device.  Run "lspci -v" and find "Multimedia audio controller" in the
output, then look at the "Subsystem:" line.  The vendor ID will probably
be replaced by the corresponding name; you can find out the number by
executing a command like "lspci -nv -s 00:07.5" (use the slot number for
your audio controller which is shown in the lspci output).

> 2) **ALL** applications I tried (alspalayer, gxine & xmms) are
> overdriving the audio path somewhere and causing distortion. The output
> level from the motherboard is not hot. In fact, even when the apps are
> up full the output level is actually down about 12-15db from where I'd
> like it, but I'm getting lots of distortion. When I reduce alsaplayer's
> level the distortion mostly goes away, although I'm left with
> considerable background hiss. In all cases I monitored the return level
> and it never causes my inputs to clip. (This level difference may be a
> pro equipment/consumer equipment issue.)
> 
> 3) With dxs_support=1 I get very bad sounding results. It appears that
> there is a bug in the ADC setting. PCM ADC is set to 48K. I think this
> is the mode I would really like to use if PCM ADC was set to 44.1K, but
> as it is it sounds terrible. dxs=2 is not very good, and dxs=3/4 are
> both pretty good. All modes have a lot of hiss compared to my HDP 9652
> and outboard D/A. (Expected...)
> 
> 
> cat /proc/asound/card0/codec97#0/ac97#0-0
> 
> 		   dxs=1	dxs=2		dxs=3/4
> <SNIP>
> PCM front DAC    : 44100Hz	22050Hz		48000Hz
> PCM Surr DAC     : 44100Hz	22050Hz		48000Hz
> PCM LFE DAC      : 44100Hz	22050Hz		48000Hz
> PCM ADC          : 48000Hz	22050Hz		48000Hz
> SPDIF Control    : 44.1kHz	44.1kHz		48000Hz
> 
> Sound Quality:	   BAD!!	not good	Good
> 
> So, I am currently using Mode 4 and getting pretty good results,
> although I think Mode 1 would be even better for me if the PCM ADC was
> set to the right value.

Something strange is going on here...

With dxs_support=1, the PCM DAC frequencies are set to match the mode
requested by the software.  Probably the VRA support in the onboard codec
is not very good.

Please show the complete contents of
/proc/asound/card0/codec97#0/ac97#0-0.

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1aIlW82GfkQfsqIRAnjlAJ91bGBURxPgjbqnmuDNWvddO30mswCfUGjh
8SWgs4P5ERJdkX9ATBGQBDw=
=q63Z
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
