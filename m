From: Guido Bakker <guido.bakker@sogeti.nl>
Subject: Re: terratec dmx xfire 1024 ac3
Date: Wed, 15 Jan 2003 11:23:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301151123.58504.guido.bakker@sogeti.nl>
References: <200301150904.21901.guido.bakker@sogeti.nl> <s5h8yxmye39.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yxmye39.wl@alsa2.suse.de>
Content-Disposition: inline
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

On Wednesday 15 January 2003 10:08, you wrote:
> Hi,
>
> At Wed, 15 Jan 2003 09:04:21 +0100,
>
> Guido Bakker wrote:
> > hi,
> >
> > i'm trying to use the optical out of my terratec dmx xfire 1024 with an
> > ac3 stream.
> >
> > root@thebox:~/alsa/alsa-tools-0.9.0rc6/ac3dec# ./ac3dec -C test.ac3
> > Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
> > ALSA lib pcm.c:1719:(snd_pcm_open_conf) Invalid type for PCM
> > iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2 definition (id: iec958,
> > value: cards.pcm.iec958)
> > snd_pcm_open: Invalid argument
> > Output open failed
> >
> > i'm getting this error, any ideas?
> >
> > i'm running alsa rc6.
>
> try the cvs version.
> should have been already fixed.

I'm now stuck to 2ch ac3 only.

Forced audio codec: hwac3
Opening audio decoder: [hwac3] AC3 pass-through SP/DIF
No accelerated IMDCT transform found
AUDIO: 48000 Hz, 2 ch, 16 bit (0x400), ratio: 56000->192000 (448.0 kbit)
Selected audio codec: [hwac3] afm:hwac3 (AC3 through SPDIF)

alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, AC3
alsa-init: soundcard set to iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2
alsa9: 48000 Hz/2 channels/4 bpf/32768 bytes buffer/Signed 16 bit Little 
Endian
AO: [alsa9] 48000Hz 2ch AC3
Building audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/8bit...
[format] Sample format big endian AC3  not yet supported
Couldn't find matching filter / ao format!

Above is the audio output from mplayer -ao alsa9 -abs 1 -ac hwac3

And the following from ac3dec -C:

Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
AC3 Stream 48.0 KHz 448 kbps
** CRC failed - skipping frame **
** CRC failed - skipping frame **
** CRC failed - skipping frame **
(and alot more of those)
Segmentation fault

I installed CVS from yesterday...

-- 
Guido Bakker

Interne Automatisering
Sogeti Nederland B.V.
T: +31 (0)20 660 66 00 + nakiesnummer 0281
e-mail: guido.bakker@sogeti.nl

Linux!  Guerrilla UNIX Development     Venimus, Vidimus, Dolavimus.
	-- Mark A. Horton KA4YBR, mah@ka4ybr.com



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
