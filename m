From: <mdeboer@iua.upf.es>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Tue, 23 Apr 2002 08:54:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1104.217.124.10.68.1019544885.squirrel@iuamtg.upf.es>
References: <0GUZ00E0JTREEW@l-daemon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0GUZ00E0JTREEW@l-daemon>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tfjellstrom@shaw.ca
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Last time I tried, rawmidi worked for me, on hw:0,1
You shouldn't need the snd-virmidi device, just the
snd-emu10k1 will do. Exactly what version of alsa-driver
are you using?

Anyway, because playing through the sequencer _does_ work,
you could indeed load the snd-virmidi device as well,
use aconnect to connect a virmidi sequencer port to the
emu10k1 synth sequencer port, and use hw:1,0 (in case
that the virmidi is your second card). On monday (at
work, where I have the SBLive! installed), I will send
you my configuration (modules.conf), and the exact
aconnect parameters.

But then again, just rawmidi -o hw:0,1 should work.

Maarten
