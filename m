From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Sat, 8 Mar 2003 18:52:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030308175244.GA32168@ulima.unil.ch>
References: <20030308144119.GB29709@ulima.unil.ch> <3E6A2856.1040602@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E6A2856.1040602@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 08, 2003 at 06:28:54PM +0100, Benny Sjostrand wrote:

> Sure you are using the latest and greatest alsa-lib? course: "ac3play:=20
> Unable to update the IEC958 control: No such file or directory", should=
=20
> not happen.

I wasn't sure, but know I am: I use the latest CVS lib also...
So the error come from another point???

> The only period sizes supported by the cs46xx hw are:
>     2048 bytes
>     1024 bytes
>       512 bytes
>       256 bytes
>       128 bytes
>         64 bytes
>         32 bytes
> Try check which period size the programs wants, as something related to=
=20
> the period_size seems to be the problem.

I suppose it's the -format option of mplayer, if I lauch it that way,
mplayer -ao alsa9 -channels 6 -format 1024 -dvd 1 I got:

Checking audio filter chain for 48000Hz/6ch/16bit -> 48000Hz/6ch/8bit...
AF_pre: af format: 2 bps, 6 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 6ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 6 channels, AC3
alsa-init: soundcard set to surround51
ALSA lib pcm.c:1739:(snd_pcm_open_conf) Invalid type for PCM surround51
definition (id: surround51, value: cards.pcm.surround51)
alsa-init: playback open error: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

And with mplayer -ao alsa9 -format 1024 I got:
Checking audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/8bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, AC3
alsa-init: soundcard set to iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=
=3D0x2
alsa-init: unable to set periodsize: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

Well, now I don't think it's the -format...

> Should work fine with xine, almost as it is, out of the box without any=
=20
> special configuration.

Well, I would really like that too ;-)

Thank you very much for your answer,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
