From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: does CS4281 have enough SRC for 4 input + 4 output channels?
Date: Tue, 28 May 2002 22:10:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205282140190.32234-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.21.0205271816120.8370-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0205271816120.8370-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: twoller@crystal.cirrus.com
Cc: Takashi Iwai <tiwai@suse.de>, pcaudio@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>, arip@bfad.de, a.geh@bfad.de
List-Id: alsa-devel@alsa-project.org

Dear Mr. Woller,

I have taken some advice from Takashi Iwai and I am implementing dual codec
support for CS4281 chip.

I wanted to have 4 channels input (FIFO0(primary codec) and
FIFO1(secondary codec)) and 4 channels output (FIFO2 and FIFO3 in the same
way).

But what do I write to SRC Slot Assignment (SRCSA) register? I only have 4
slots while I need 8! 

Should I first write the playback and capture slots of the primary codec, then
set up FIFO0 and FIFO2, and then write slots of the secondary codec to SRCSA
and set up FIFO1 and FIFO3 ?


If this is indeed hardware limitation then I have the following 3 questions:

1. I am going to use CS4299 codecs at 8000 Hz only. They have internal sample
rate converters (SRC) working at 8000 Hz. Do I really need to use SRC in
CS4281? What will happen if I just set up the FIFOs and do not configure SRCSA
at all?

2. I really need in fact only input from left channels of both codecs and
output to the right channels of both codecs. May I for example program SRCSA
left capture slot CLSS to 10 (Left PCM record) and the right capture slot
CRSS to 20 (Secondary Left PCM record) or 22, 24 etc?
I would then do the same trick with the playback slots.
I would get the capture stereo stream from left PCM channels of the primary and
secondary codecs and play 2 channel stereo to the right channels of both
codecs.

3. Is it possible to have all the 4 channels interleaved? I mean can two DMA
engines write to the same memory buffer, just with 2 sample offset and skipping
each 2 samples?


Best regards,
--
Tomasz Motylewski

P.S. To ALSA developers: if my guess is right, then we may support all 4
channels full duplex only at a few predefines speeds. But we may use 4 SRC
units and for example make one codec any-speed, or all playback any-speed, or
all left channels (packed in a single stereo stream) any-speed. Does ALSA
support such wild configurations?


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
