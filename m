From: Raymond <rayau@netvigator.com>
Subject: au88x0_synth
Date: Sun, 20 Mar 2005 09:11:08 +0800
Message-ID: <423CCDAC.80401@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> > Lee Revell wrote:
> > Looks like this chipset has a wavetable synth.  And I noticed some
> > references to a driver on the openvortex list.  Would it be possible 
> > for ALSA to support it?

> Manuel Jander wrote:
>  Of course, but there are some unresolved hardware issues. The
>  WaveTable helper hardware is very similar to the trident
>  Wavetable helper hardware. It does not interpret MIDI directly, but
>  at least does some effect processing in hardware.


http://sourceforge.net/mailarchive/message.php?msg_id=6004190

1) Is the Trident Wavetable working ?

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x84.htm

There is no Makefile inside /alsa-kernel/Documentation/Docbook

2) How can I converted the latest version of writing-an-alsa-driver.tmpl
to HTML format

3) Is the information about ALSA sequencer in
http://www.alsa-project.org/~iwai/lk2k/lk2k.html still valid for ALSA
1.0.x ?

4)  In addition to the callback functions used in Midi sequencer
interface, what other functions/modules will the wavetable synth (kernel 
client) need to be implmemented ?

static snd_midi_op_t vortex_midi_ops = {
	snd_vortex_note_on,
	snd_vortex_note_off,
	snd_vortex_key_press,
	snd_vortex_terminate_note,
	snd_vortex_control,
	snd_vortex_nrpn,
	snd_vortex_sysex,
};

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-utils/seq/

5) Is the aplaymidi the only tool to test and debug the wavetable synth
? ( Any GUI application )

Refer to http://www.3dsoundsurge.com/archive/week16.htm
(iii) OPL3 Support: Both Windows DOS boxes and real-mode DOS now support
4-operator OPL3 FM synthesis, in addition to 2-operator OPL2 FM synthesis.

6) Do au88x0 support OPL3 ?

The "vortexcontrol" use alsa-lib API to play the audio
samples inside au30gm.arl through hw:0,0.

7) How can the audio sample be played within the driver using the
  soundfont through hw:0,0 in a 16 voice synth for au8810 (without WT) ?


Raymond


























-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
