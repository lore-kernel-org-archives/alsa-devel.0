From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: pcm_ladspa and multichannel filters
Date: Wed, 28 Apr 2004 23:44:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56-Maildir.0404282327060.21234@yme.midgardsormen.net>
References: <Pine.LNX.4.56-Maildir.0404230141120.1216@yme.midgardsormen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56-Maildir.0404230141120.1216@yme.midgardsormen.net>
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

On Fri, 23 Apr 2004, Erik Inge Bolsø wrote:
>See subject. Has anyone got this working? I've followed the examples and
>got a few different filters working (chorus, delay), but am having trouble
>with more complex ones - and suspect a bug in alsa-lib.
>
>Current ALSA CVS version, as of a few hours ago.
>
>The plugin in question is from swh-plugins-0.4.3.tar.gz. Had the same
>problem with a plugin from ladspa's cmt_src_1.15.tgz
>
>The .asoundrc below
>
>pcm._novoice {
>        type ladspa
>        slave.pcm "plughw:0,0";
>        path "/usr/local/lib/ladspa";
>        playback_plugins [
>                {
>                        label karaoke
>                        policy none
>                        input {
>                                controls
>                                {
>                                        "Vocal volume (dB)" -30
>                                }
>                                bindings
>                                {
>                                        0 "Left in"
>                                        1 "Right in"
>                                }
>                        }
>                        output {
>                                bindings
>                                {
>                                        0 "Left out"
>                                        1 "Right out"
>                                }
>                        }
>                }
>        ]
>}
>
>pcm.novoice {
>        type plug
>        slave.pcm "_novoice";
>}
>
>gives me
>
>knan@monster:~$ aplay -Dnovoice PCM1.wav
>Playing WAVE 'PCM1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>ALSA lib pcm_ladspa.c:439:(snd_pcm_ladspa_allocate_instances) Unable to
>connect input port of plugin 'Karaoke' channel 1 depth 0
>aplay: set_params:880: Unable to install hw params:
>ACCESS:  RW_INTERLEAVED
>FORMAT:  S16_LE
>SUBFORMAT:  STD
>SAMPLE_BITS: 16
>FRAME_BITS: 32
>CHANNELS: 2
>RATE: 44100
>PERIOD_TIME: (74285 74286)
>PERIOD_SIZE: 3276
>PERIOD_BYTES: 13104
>PERIODS: (2 3)
>BUFFER_TIME: (148594 148595)
>BUFFER_SIZE: 6553
>BUFFER_BYTES: 26212
>TICK_TIME: 10000
>
>
>I've tried tracing it in gdb, but gdb keeps playing tricks on me - so no
>luck yet.
>
>At one point, in snd_pcm_ladspa_connect_plugin, I saw
>the parameters "plugin" and "io" resolve to the same address, but haven't
>been able to reproduce yet. plugin->input looked correct, though.

Red herring. printf's show that this was gdb playing tricks.

I get this, though.

snd_pcm_ladspa_connect_plugin: io->port_bindings_size: 2
snd_pcm_ladspa_connect: instance->channel = 0, channel = 0
snd_pcm_ladspa_connect_plugin: io->port_bindings_size: 2
snd_pcm_ladspa_connect: instance->channel = 0, channel = 1
ALSA lib pcm_ladspa.c:455:(snd_pcm_ladspa_allocate_instances) Unable to
connect input port of plugin 'Karaoke' channel 1 depth 0
aplay: set_params:880: Unable to install hw params:

Hmmm. On second reading, it seems alsa-lib only handles mono-input and
mono-output ladspa plugins, even though the config parser is smart enough
to understand the concept of multichannel plugins. Damn.

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
