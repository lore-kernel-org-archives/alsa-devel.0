From: "Merrony, Stephen (London)" <merronys@exchange.uk.ml.com>
Subject: RE: Sequencer API Query
Date: Wed, 5 Feb 2003 09:48:43 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <61627AE0C39BD11182D600805FE6527B0A02D681@lonim26408.uk.ml.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK - at least it's not my dodgy programming that's to blame this time [;-)

Is it either (i) correct, (ii) safe, or (iii) OK in practice(!),  to assume
16 channels per (wavetable) synth?

Thanks
           Steve


> Merrony, Stephen (London) wrote:
> > I would like to be able to query the number of MIDI channels available
> per
> > client, but all of snd_seq_port_info_get_midi_channels(),
> > snd_seq_port_info_get_midi_voices(),
> snd_seq_port_info_get_synth_voices()
> > return 0.
> >
> > I am using  a Creative SoundBlaster Live!  And it is the wavetable
> synths I
> > am interested in.
> 
> The driver doesn't bother to set these values.
> 
> > I notice that the input ports correctly return a value of 16 when
> queried
> > with snd_seq_port_info_get_midi_channels().
> 
> Well, this may not be entirely correct if the port is connected to a
> device using less than 16 channels.  ;-)
> 
> 
> HTH
> Clemens
> 



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
