From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: usb-audio
Date: Tue, 28 Oct 2003 12:48:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310281248.17285.bergtroll@gmx.li>
References: <20031027180300.GA5016@Zeryn> <200310281141.07453.bergtroll@gmx.li> <s5hk76pliro.wl@bari.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk76pliro.wl@bari.suse.de>
Content-Disposition: inline
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

Am Dienstag, 28. Oktober 2003 12:10 schrieb Takashi Iwai:
> 
> > No, I don't think it is.
> > I get similar problems with my emi 2|6 and alsaplayer, mplayer, xmms,
> > ...
>
> did you use plughw instead of hw in all cases?
> otherwise they won't work always.
plughw doesn't work at all!

> mplayer has an option to specify the device name.
> it'd be better to define a new pcm in ~/.asoundrc such as
>
> 	pcm.emi26 {
> 		type plug
> 		slave.pcm "hw:0"
> 	}
>
> (where "hw:0" should be changed to the corresponding one)
>
> and run like
>
> 	% mplayer -ao alsa9:emi26 ...
>
gives:
Checking audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, big endian signed int 
AF_pre: 44100Hz 2ch Signed 16-bit (Big-Endian)
alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit 
(Big-Endian)
alsa-init: soundcard set to emi26
alsa9: 44100 Hz/2 channels/2 bpf/32768 bytes buffer/Signed 16 bit Big 
Endian
AO: [alsa9] 44100Hz 2ch Signed 16-bit (Big-Endian) (2 bps)
Building audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
Video: no video
Starting playback...


MPlayer interrupted by signal 11 in module: play_audio

and no sound, whereas accessing hw:1 directly at least produces output.
playing through plug-hw with aplay works, though
alsaplayer doesn't like the card with plug-layer. (alsaplayer seems to 
have deeper problems, since its doesn't work on the internal snapper, as 
well.

(Oh: kernel 2.6-test8-benh from bitkeeper, if that is of any interest)

Have fun*

Niklas



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
