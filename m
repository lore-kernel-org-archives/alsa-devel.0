From: Ludwig Schwardt <schwardt@sun.ac.za>
Subject: Multiple Delta 1010LT woes
Date: Fri, 20 Feb 2004 17:51:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40362CEE.8060907@sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi,

I'm playing around with the M-Audio (MidiMan) Delta 1010LT card. My plan 
is to install three of them, synced via word clock, and record the 
resulting 24 analog channels via JACK. I understand this requires some 
.asoundrc magic.

Questions:

- Why does the card show up with 12 inputs under JACK? As far as I could 
tell, the card has 8 analog ins and 2 spdif ins. Where are the extra two 
inputs? Shouldn't the card then be a Delta 1210LT? :->

- I've got the "plug" plugin in .asoundrc to select the first eight 
channels, but this has latency issues. Is "multi" the right way to go?

- Repeated attempts to create a working multi plugin have failed, based 
on all the usual multicard snippets floating around on the Web. I have 
only one Delta at the moment, so I've tried it alone and together with 
the dummy soundcard (i.e. one slave or two in the plugin definition). Is 
it OK to have only one card in multi?

In JACK I get the error:
ALSA: no playback configurations available (Invalid argument)

And with aplay and arecord I get:
arecord: set_params:805: Broken configuration for this PCM: no 
configurations available

Takashi suggested in an old post (can't find it now) that it might have 
something to do with the lopsided input/output channel count of the 
ICE1712. Any suggestions how to get past it, if that's the case?

I would really love to hear from anyone who managed to string two or 
more ICE1712 cards together and used them successfully for recording 
under JACK.

Thanks very much in advance,

Ludwig Schwardt



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
