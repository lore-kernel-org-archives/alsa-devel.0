From: Bryan Ischo <bryan@ischo.com>
Subject: Problem when using silence 'trick'
Date: Thu, 24 Feb 2011 00:11:12 -0800
Message-ID: <4D6612A0.9000106@ischo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sasl.smtp.pobox.com (b-pb-sasl-quonix.pobox.com [208.72.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id B8BCE24463
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 09:11:19 +0100 (CET)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 649AF1C50
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 03:11:14 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 615321C4F
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 03:11:14 -0500 (EST)
Received: from [192.168.1.88] (unknown [174.62.74.120]) (using TLSv1 with
	cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
	requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C746A1C4C for
	<alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 03:11:13 -0500 (EST)
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

Hi ALSA developers!

I am working on my first project that uses sound under Linux, and I've 
chosen to implement directly to the ALSA API.  I am amazed that I was 
able to get sound working in so few lines of code with ALSA.  I like the 
API and its performance alot but I have a problem!

My program, early in its development, wanted to play just one sound 
stream at a time; and it is a sound stream which normally delivers audio 
at a sufficent rate to avoid XRUN but in some circumstances the thread 
generating audio cannot keep up and it falls behind, resulting in XRUN.  
Well I found that in cases where the audio thread is 'almost' keeping 
up, the standard behavior of allowing an XRUN to occur, detecting it on 
the next call to snd_pcm_writei, and 'fixing' it by calling 
snd_pcm_prepare() and then proceeding to continue delivering audio 
frames, had the following unfortunate problems:

1. The audio sounds crackly and awful (which is to be expected to some 
degree with XRUN)
2. The time taken to re-prepare the ALSA device is counterproductive; it 
takes even more time away from the thread that is delivering audio and 
thus makes the case where the audio is very marginally behind 'real 
time' much worse.

I thought, if only I could tell ALSA to just play silence if it has run 
out of frames of audio instead of XRUNning, and then I can add real 
frames of audio back in as soon as they are available and pick up the 
audio stream where it left off.

Some digging into the ALSA API and I found that someone on the ALSA team 
had already beaten me to the thought!  The API docs kind of hint at how 
you would go about doing this, and I found this technique to be very 
successful:

1. Use snd_pcm_sw_params_set_stop_threshold to set the stop threshold to 
0.  Now, no XRUN - ALSA will keep looping in the circular buffer and 
play whatever is there; and if you haven't updated quickly enough, you 
just get looping snippets of audio.

2. Use snd_pcm_sw_params_set_silence_threshold to 0 and 
snd_pcm_sw_params_set_silence_size to set the silence 'size' to the 
boundary value obtained by calling snd_pcm_sw_params_get_boundary().  
Now ALSA is instructed to fill the already-played portions of the 
circular buffer with silence, which means that even when looping due to 
XRUN, no sound is played over and over, instead silence is played.

Hey presto - works perfectly!

Then later on I needed to play more than one sound simultaneously.  It 
turns out that I had been opening the "plughw:0,0" device originally and 
this had been working great with my sound trick.  The problem is, you 
cannot use plughw:0,0 and open it more than once to play more than one 
sound simultaneously; the second open will fail.

So after some digging I found that the device I really should have been 
using all along is called "default" (hey, you'd think it would be 
obvious, but somehow I never found ALSA documentation that told me to do 
this).

Now the real problem: when I use the "default" device with my silence 
technique, I have no problem playing multiple audio streams 
simultaneously by opening the "default" device multiple times and 
simultaneously playing streams into the different devices.  BUT, 
whenever I cannot deliver audio fast enough to a stream, and the silence 
trick takes over and the stream plays some silence - boom, the device 
goes silent forever.  I don't get any errors from any ALSA function, I 
just get silence no matter what I write into the device after that 
point.  This is in sharp contrast to the plughw:0,0 device, which does 
play silence if I don't deliver audio fast enough but immediately plays 
whatever audio I do end up delivering to it when I finally have audio to 
deliver.

Am I using an invalid technique with this silence trick?
Is this a known and expected behavior of the "default" device?
Or could something else be going on?

Thanks for any advice you can give!

Best wishes,
Bryan
