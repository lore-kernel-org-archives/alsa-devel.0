From: Ove Kaaven <ovek@transgaming.com>
Subject: PCM hw mixing with volume
Date: Sun, 07 Mar 2004 15:51:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078671074.18057.17.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

We have some games that want to mix several dynamic sound streams.
That's easy enough at first glance, just snd_pcm_open() for each stream
they want to output (and do software mixing when that fails). However,
it seems that they want each stream to have independent volume and pan
controls.

As far as I can tell, this is possible to do on SB Live and Audigy by
messing with the "EMU10K1 PCM Send" volume controls, but this is pretty
device-specific and few other hw-mixing ALSA drivers seem to have
exposed such a feature. (And software plugins are not of interest.)

Are you planning to standardize such features or design a
device-independent API for it? (And my manager wants to know which ALSA
release this might get implemented in...)




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
