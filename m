From: Benny Sjostrand <gorm@cucumelo.org>
Subject: More CS4630 improvements, finally multi PCM channel support
Date: Thu, 01 Aug 2002 00:11:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D48607D.5020406@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I've implemented multi PCM channel support for cs46xx based soundcards, 
the PCM multichannel  should work on any soundcard
with a cs4630 DSP. It should be possible to play 31 simultaneous PCM 
playbacks at 6 diferents sample rates. 1 slot is always  reserved for 
capture, therefor 31. Each time the DSP needs to instanciate a SRC 
(Sample Rate Converter) task it costs memory and MIPS in the DSP 
therefor there only reserved place for 6 simultaneous SRC. PCM channels 
with the same sample rate shared the same SRC.
The part of the driver that resource handles the PCM channel and SRC 
instances on DSP is complex, so there many drastic changes in 
cs46xx_lib.c, hopefully nothing that worked before is broken.
NOTE: i've not tested 31 simultaneous playback yet, only 6 for the 
moment (in theory all 31 should work)

That's it, ending up here, the aditional feutures should be:
- PCM multichannel.
- Secondary CODEC, ALSA mixer, front && rear output (same output from 
rear && front).
- SPDIF output. (i believe that i need some more help from Cirrus and 
maybe Hercules and other card manufacturers to get  SPDIF input working)

And this is like my "pre-proposal" to a patch for the ALSA project. For 
the moment i'm not planning to try implement any
other feutures before getting this parts "stable enough", but we will 
see, things change quickly -:)

Downloads:
http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020731.diff.gz
http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020731.tar.gz

/Benny




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
