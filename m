From: David B Harris <david@eelf.ddts.net>
Subject: Re: SIS7012 works but get's frozen
Date: Sat, 19 Jul 2003 06:25:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030719062542.5cade906.david@eelf.ddts.net>
References: <1058568436.3642.15.camel@julius>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="w3EPyi:v.02c=.K/"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1058568436.3642.15.camel@julius>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--w3EPyi:v.02c=.K/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 18 Jul 2003 18:47:17 -0400
"P.I.Julius" <julius@solutions-i.org> wrote:
> Hi all ALSA developers
> 
> I have a sis7012 sound card with my new laptop SonyVaio PCG-GRT100 but
> the sound is not working. I tried out with the kernel i810_audio modul,
> with the OpenSounSystem, and with the alsa too, but with every driver my
> sound card is not working. The modules are loaded, and i can change the
> volume with aumix, but if i try to play a sound file, just the first
> second gets played, and then my box gets frozen.
> 
> Please help, i really want to hear more then 1 second from a mp3 file :)
> Thanks a lot
> Julius

I'd like to "me too" this particular report; I use the on-board audio of
the ECS K7S5A motherboard, and 0.9.5 doesn't seem to be particularily
happy with it. Here are some error messages:

[ david@willow: ~/music/ ]$ xmms
ALSA lib pcm_params.c:2096:(snd_pcm_hw_refine_slave) Slave PCM not usable
[ david@willow: ~/music/ ]$ mpg321 -o alsa Don\ MacLean\ -\ American\ Pie.mp3 
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Playing MPEG stream from Don MacLean - American Pie.mp3 ...
MPEG 1.0 layer III, 192 kbit/s, 44100 Hz stereo
ALSA lib pcm_params.c:2096:(snd_pcm_hw_refine_slave) Slave PCM not usable
ALSA snd_pcm_hw_params_any error: Invalid argument
libao - OSS cannot set channels to 2
Can't find a suitable libao driver. (Is device in use?)
[ david@willow: ~/music/ ]$ 
[ david@willow: ~/music/ ]$ esd -tcp -public -nobeeps -as 2
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 44.1Khz, stereo, 16bit failed
Trying 44.1Khz, 8bit stereo.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 48Khz, 16bit stereo.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 48Khz, stereo,16bit failed
Trying 22.05Khz, 8bit stereo.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 22.05Khz, stereo, 8bit failed
Trying 44.1Khz, 16bit mono.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 44.1Khz, mono, 8bit failed
Trying 22.05Khz, 8bit mono.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 22.05Khz, mono, 8bit failed
Trying 11.025Khz, 8bit stereo.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 11.025Khz, stereo, 8bit failed
Trying 11.025Khz, 8bit mono.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 11.025Khz, mono, 8bit failed
Trying 8.192Khz, 8bit mono.
SNDCTL_DSP_SETFMT: Invalid argument
Audio device open for 8.192Khz, mono, 8bit failed
Trying 8Khz, 8bit mono.
SNDCTL_DSP_SETFMT: Invalid argument
Sound device inadequate for Esound. Fatal.
[ david@willow: ~/music/ ]$ 

Thanks :)

--w3EPyi:v.02c=.K/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GRymuCQ/g7GxJcARAgZcAJ94hks9IgFP/AfpFu2dU7TsTcNx3ACcCFJ4
h+wEnIGJQeb8NUrIJZerUZE=
=kk2Z
-----END PGP SIGNATURE-----

--w3EPyi:v.02c=.K/--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
