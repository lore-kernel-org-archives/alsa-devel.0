From: Mark Knecht <markknecht@comcast.net>
Subject: No /dev/snd/seq?
Date: Wed, 27 Aug 2003 18:13:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062033229.1475.14.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

What causes this? What should have installed or created /dev/snd/seq?

(RME HDSP 9652) MIDI does work using /dev/midi00

Thanks,
Mark

bash-2.05b$ rosegardensequencer 
kbuildsycoca running...
rosegardensequencer: Registering with DCOP server
rosegardensequencer: created plugin manager
MappedAudioPluginManager::discoverPlugins - discovering plugins
Rosegarden 4-0.9 - AlsaDriver - alsa-lib version 0.9.6
cannot connect to jack server
cannot connect to default JACK server
ALSA lib seq_hw.c:446:(snd_seq_hw_open) open /dev/snd/seq failed: No
such file or directory
rosegardensequencer: RosegardenSequencer - started OK
rosegardensequencer: seq.c:875: snd_seq_query_next_client: Assertion
`seq && info' failed.
bash-2.05b$ Mutex destroy failure: Device or resource busy


bash-2.05b$ ls /dev/snd/
controlC0  hwC0D0  midiC0D0  midiC0D1  pcmC0D0c  pcmC0D0p  timer
bash-2.05b$ 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
