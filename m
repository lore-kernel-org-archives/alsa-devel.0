From: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Subject: Re: asoundrc problem
Date: Thu, 30 Jan 2003 12:06:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301301156380.8106-100000@rzstud2.stud.uni-karlsruhe.de>
References: <s5h7kcmlxli.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kcmlxli.wl@alsa2.suse.de>
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

On Thu, 30 Jan 2003, Takashi Iwai wrote:

> At Thu, 30 Jan 2003 09:34:13 +0100 (CET),
> Oliver Schrempf wrote:
> >
> > Since my last mail where I sent my current settings I still have the
> > problem, that I recieve the following error message
> >
> > arecord: main:462: audio open error: No such file or directory
>
> what shows if you run "aplay -L" and "aplay -l" ?
> does pcm.multi appear there?
OK, the modules where not loaded :-(
(I'll kick the guy who touched my machine...)

Now again:
/home/oliver>arecord -Dplug:multi -c 16 test.wav
Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Channels 16
arecord: set_params:765: Broken configuration for this PCM: no
configurations available

/home/oliver> aplay -l
card 0: 88MT [TerraTec EWS 88MT], device 0: ICE1712 multi [ICE1712 multi]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: 88MT [TerraTec EWS 88MT], device 1: ICE1712 consumer [ICE1712
consumer]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: 88MT [TerraTec EWS 88MT], device 2: ICE1712 consumer (DS) [ICE1712
consumer (DS)]
  Subdevices: 6/6
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
card 1: 88MT_1 [TerraTec EWS 88MT], device 0: ICE1712 multi [ICE1712
multi]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: 88MT_1 [TerraTec EWS 88MT], device 1: ICE1712 consumer [ICE1712
consumer]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: 88MT_1 [TerraTec EWS 88MT], device 2: ICE1712 consumer (DS)
[ICE1712 consumer (DS)]
  Subdevices: 6/6
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5

/home/oliver> aplay -L
<SNIP>
cards 'cards.pcm'
front 'cards.pcm.front'
rear 'cards.pcm.rear'
center_lfe 'cards.pcm.center_lfe'
surround40 'cards.pcm.surround40'
surround51 'cards.pcm.surround51'
iec958 'cards.pcm.iec958'
spdif 'cards.pcm.iec958'
multi {
        type multi
        slaves.a.pcm 'hw:0,0,0'
        slaves.a.channels 8
        slaves.b.pcm 'hw:1,0,0'
        slaves.b.channels 8
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave a
        bindings.2.channel 2
        bindings.3.slave a
        bindings.3.channel 3
        bindings.4.slave a
        bindings.4.channel 4
        bindings.5.slave a
        bindings.5.channel 5
        bindings.6.slave a
        bindings.6.channel 6
        bindings.7.slave a
        bindings.7.channel 7
        bindings.8.slave b
        bindings.8.channel 0
        bindings.9.slave b
        bindings.9.channel 1
        bindings.10.slave b
        bindings.10.channel 2
        bindings.11.slave b
        bindings.11.channel 3
        bindings.12.slave b
        bindings.12.channel 4
        bindings.13.slave b
        bindings.13.channel 5
        bindings.14.slave b
        bindings.14.channel 6
        bindings.15.slave b
        bindings.15.channel 7
}
mplug {
        type plug
        slave.pcm multi
}




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
