From: "John L. Utz III" <jutz@dmx.com>
Subject: alsa-plugin: rate-libsamplerate,
	buffer shrinkage problem
Date: Thu, 08 Jan 2009 09:39:14 -0800
Message-ID: <49663A42.2040700@dmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FF961037EE
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 18:40:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi;

Our legacy product code is tormenting me again. :-(

i have a 3rd party sound-fiddling library that only works with an 8k 
buffer. the company that wrote it is long gone. i cant change this.

i have a enourmous array of content that is coded at 44.1K. i cant 
change this.

i have to use a cheap soundblaster audigy card (ca0106) that only 
supports 48K. it sounds really good at 48K, so it seems like a winner.

the samplerate plugin is almost perfect for helping me successfully use 
the 48K only card with our 44.1K content.

*almost*. :-(

if i use the samplerate plugin thusly in my CA0106.conf:

CA0106.pcm.front.0 {
         @args [ CARD  ]
         @args.CARD {
                 type string
         }
#        type hw
#        card $CARD
         type rate
         slave {
         pcm "hw:0,0"
         rate 48000
         }
         converter "samplerate"
}


I no longer get a 8192 byte buffer, i get a 7526 byte buffer. :-(

snd_pcm_hw_params_set_buffer_size_near() fails if i try and set it to 
8192, but it accepts 7526 or 15092.

I *assume* that either the samplerate plugin or libsamplerate are 
consuming part of the buffer for the resample job. Not at all unreasonable.

But it seems like i should be able to bump up the internal working 
buffer size so that i get my 8192 byte submittal buffer back.

Does anybody have any suggestions? Is there a flag or config entry that 
i have missed?

Or do i need to go hack something? That would be fine, but it would be 
nice to know where to look. :-)

Here is a succinct example of the problem, first i call speaker-test 
without a rate argument and then with the rate argument:

test-gntopxsg ~ # speaker-test -c2 -Dfront -t sin

speaker-test 1.0.17

Playback device is front
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 16384
Period size range from 15 to 8193
Using max buffer size 16384
Periods = 4
was set period_size = 4096
was set buffer_size = 16384

test-gntopxsg ~ # speaker-test -c2 -Dfront -t sin -r44100

speaker-test 1.0.17

Playback device is front
Stream parameters are 44100Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 44100Hz (requested 44100Hz)
Buffer size range from 29 to 15052
Period size range from 14 to 7527
Using max buffer size 15052
Periods = 4
was set period_size = 3763
was set buffer_size = 15052

tnx in advance for any help you all can provide!

johnu
