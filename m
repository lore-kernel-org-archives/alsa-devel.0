From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sequencer API Query
Date: Wed, 5 Feb 2003 09:20:02 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302050853350.14453-100000@studcom.urz.uni-halle.de>
References: <61627AE0C39BD11182D600805FE6527B0A02D67F@lonim26408.uk.ml.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <61627AE0C39BD11182D600805FE6527B0A02D67F@lonim26408.uk.ml.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Merrony, Stephen (London)" <merronys@exchange.uk.ml.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Merrony, Stephen (London) wrote:
> I would like to be able to query the number of MIDI channels available per
> client, but all of snd_seq_port_info_get_midi_channels(),
> snd_seq_port_info_get_midi_voices(), snd_seq_port_info_get_synth_voices()
> return 0.
>
> I am using  a Creative SoundBlaster Live!  And it is the wavetable synths I
> am interested in.

The driver doesn't bother to set these values.

> I notice that the input ports correctly return a value of 16 when queried
> with snd_seq_port_info_get_midi_channels().

Well, this may not be entirely correct if the port is connected to a
device using less than 16 channels.  ;-)


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
