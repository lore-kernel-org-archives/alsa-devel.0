From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Mon, 10 Mar 2003 22:15:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030310211540.GA31584@ulima.unil.ch>
References: <20030308144119.GB29709@ulima.unil.ch> <3E6A2856.1040602@cucumelo.org> <20030308175244.GA32168@ulima.unil.ch> <s5hu1eb471j.wl@alsa2.suse.de> <20030310144608.GB14537@ulima.unil.ch> <s5hsmtv46kv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hsmtv46kv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 10, 2003 at 03:52:32PM +0100, Takashi Iwai wrote:

> ah, now got the point.
>=20
> surround51 pcm is for ANALOG 5.1 output.  and it's NOT supported on
> cs46xx yet.
>=20
> the easiest way to check is to use ac3dec in alsa-utils.
> run with -C option for AC3-passthru mode.

;-)
With -C I don't hear anything with my file, so with -P, but with -R I
can hear the sound, but my receiver only tell me about stereo, no 5.1.

Something I really don't understand:

./ac3dec -C /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3
Using PCM device 'iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2'
AC3 Stream 44.1 KHz 256 kbps

Don't gives me any sound, but
./ac3dec -D iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2 /data/lin=
ux/dvb/from_beyond_the_edge_44k_256kbps.ac3
5.1 Mode 44.1 KHz 256 kbps Complete Main Audio Service
Using PCM device 'iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2'
does (stereo only).

Where could I find info about those?

Oh, just for the info, for playing with mplayer, the abs option is
really cool:

mplayer -dvd 1 -ao alsa9 -channels 2 -abs 3
allow me to hear stereo sound with alsa:
Checking audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit
(Little-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa9: 48000 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa9] 48000Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...

And with mplayer -dvd 1 -ao alsa9:iec958 -channels 2 -abs 3
I have also great stereo sound:
Checking audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit
(Little-Endian)
alsa-init: soundcard set to iec958
alsa9: 48000 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa9] 48000Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...

But with
mplayer -dvd 1 -ao alsa9:iec958 -channels 6 -abs 3:
Checking audio filter chain for 48000Hz/6ch/16bit ->
48000Hz/6ch/16bit...
AF_pre: af format: 2 bps, 6 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 6ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 6 channels, Signed 16-bit
(Little-Endian)
alsa-init: soundcard set to iec958
alsa-init: unable to set channels: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

Any idea?
And yes, the DVD I have tried are 5.1 (also DTS)...

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
