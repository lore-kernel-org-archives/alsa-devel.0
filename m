From: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Subject: Re: asoundrc problem
Date: Mon, 3 Feb 2003 12:06:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302031158520.11046-100000@rzstud4.stud.uni-karlsruhe.de>
References: <s5hlm11i53e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm11i53e.wl@alsa2.suse.de>
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

> > /home/oliver>arecord -Dplug:multi -c 16 test.wav
> > Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Channels 16
> > arecord: set_params:765: Broken configuration for this PCM: no
> > configurations available
>
> hmm..  does it work when you specify the format and rate?
>
> 	% arecord -Dplug:multi -c16 -fS16_LE -r48000 foo.wav
>
> (or -fS32_LE as a native format, then you don't need plug layer)

None of that works, always the same error as above


> also, try whether areocord (with -c 8) works on each card (hw:0 and
> hw:1).
It works with -Ddefault
 or with -Dice_a and the following pcm
pcm.ice_a {
        type plug
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.2 1
        ttable.3.3 1
        ttable.4.4 1
        ttable.5.5 1
        ttable.6.6 1
        ttable.7.7 1
        slave.pcm {
                type hw
                card 0
                device 0
        }
}

-Dhw:0,0 gives
arecord -Dhw:0,0 -c8 -fS16_LE -r44100 foo.wav
Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Channels 8
arecord: set_params:787: Sample format non available

Oli



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
