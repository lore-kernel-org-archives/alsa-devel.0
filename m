From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: au88x0_synth
Date: Thu, 24 Mar 2005 10:34:00 -0400
Message-ID: <1111674841.3353.11.camel@localhost>
References: <423CCDAC.80401@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <423CCDAC.80401@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

On Sun, 2005-03-20 at 09:11 +0800, Raymond wrote:
> Hi,
> 
> > > Lee Revell wrote:
> > > Looks like this chipset has a wavetable synth.  And I noticed some
> > > references to a driver on the openvortex list.  Would it be possible 
> > > for ALSA to support it?
> 
> > Manuel Jander wrote:
> >  Of course, but there are some unresolved hardware issues. The
> >  WaveTable helper hardware is very similar to the trident
> >  Wavetable helper hardware. It does not interpret MIDI directly, but
> >  at least does some effect processing in hardware.
> 
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=6004190
> 
> 1) Is the Trident Wavetable working ?

No idea. I don't have one. I just looked at the datasheet of the trident
4DX chip and found very similar to the aureal chip, when looking at the
big picture.

> http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x84.htm
> 
> There is no Makefile inside /alsa-kernel/Documentation/Docbook

> 4)  In addition to the callback functions used in Midi sequencer
> interface, what other functions/modules will the wavetable synth (kernel 
> client) need to be implmemented ?
> 
> static snd_midi_op_t vortex_midi_ops = {
> 	snd_vortex_note_on,
> 	snd_vortex_note_off,
> 	snd_vortex_key_press,
> 	snd_vortex_terminate_note,
> 	snd_vortex_control,
> 	snd_vortex_nrpn,
> 	snd_vortex_sysex,
> };

We need the WT engine working. The rest is just a matter of writing the
glue code (pretty straitforward).

> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-utils/seq/

> Refer to http://www.3dsoundsurge.com/archive/week16.htm
> (iii) OPL3 Support: Both Windows DOS boxes and real-mode DOS now support
> 4-operator OPL3 FM synthesis, in addition to 2-operator OPL2 FM synthesis.
> 
> 6) Do au88x0 support OPL3 ?

No. It supports some memory registers to aid software emulation, but
there is no real OPL hardware onboard the aureal chips.

> The "vortexcontrol" use alsa-lib API to play the audio
> samples inside au30gm.arl through hw:0,0.

Thats because its just for hearing a sample. Its not even close to what
has to be done for a Wavetable implementation. The higher level arl
soundbank interpreter is very valuable, but on the hardware side we are
missing the WT engine support.

> 7) How can the audio sample be played within the driver using the
>   soundfont through hw:0,0 in a 16 voice synth for au8810 (without WT) ?

The au8810 does not have the WT engine, so wavetable synthesis has to be
done with software emulation, and feeding the resulting audio into a
dedicated ADB PCM channel.

Best Regards,
-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
