From: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Tue, 23 Apr 2002 01:54:22 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0GV000LJSGHPTE@l-daemon>
References: <0GUZ00E0JTREEW@l-daemon>
 <1104.217.124.10.68.1019544885.squirrel@iuamtg.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1104.217.124.10.68.1019544885.squirrel@iuamtg.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: mdeboer@iua.upf.es
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On April 23, 2002 12:54 am, you wrote:
> Last time I tried, rawmidi worked for me, on hw:0,1
> You shouldn't need the snd-virmidi device, just the
> snd-emu10k1 will do. Exactly what version of alsa-driver
> are you using?

0.9.0beta12

> Anyway, because playing through the sequencer _does_ work,
> you could indeed load the snd-virmidi device as well,
> use aconnect to connect a virmidi sequencer port to the
> emu10k1 synth sequencer port, and use hw:1,0 (in case
> that the virmidi is your second card). On monday (at
> work, where I have the SBLive! installed), I will send
> you my configuration (modules.conf), and the exact
> aconnect parameters.

Thanks.

> But then again, just rawmidi -o hw:0,1 should work.
>

Unfortunatly it does not... Im using the same settings I used for a previous 
version of alsa 0.9.0, and had rawmidi working...

-- 
Thomas Fjellstrom
tfjellstrom@shaw.ca
http://strangesoft.net
