From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: alsa device drain power
Date: Fri, 18 Dec 2009 14:28:35 +0100
Message-ID: <4B2B8383.70806@gandalf.sssup.it>
References: <4B29F03F.4020100@gandalf.sssup.it>
	<20091217110334.GB12245@sirena.org.uk>
	<4B2B536F.4060800@gandalf.sssup.it>
	<20091218113225.GD19544@sirena.org.uk>
	<4B2B73A3.1010702@gandalf.sssup.it>
	<20091218125356.GA29829@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 06CAE1038DD
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 14:28:52 +0100 (CET)
In-Reply-To: <20091218125356.GA29829@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown wrote:
> On Fri, Dec 18, 2009 at 01:20:51PM +0100, Michael Trimarchi wrote:
>
>   
>> I don't send any sound to the device so it remains on, it's the
>> correct behavior?
>>     
>
> What do you mean by that - what exactly is "send any sound to the
> device" in this context?  Do you mean that you aren't playing any audio
> from the CPU?  
I don't play any audio file (mp3 ogg) to the device but open it during 
boot sequence
using the SpeakerOut profile. The speake audio path is not used.
For design decision Android open the device in
AudioFlinger Theread:

I/AudioHardwareALSA(  867): Initialized ALSA PLAYBACK device 
AndroidPlayback_Speaker_normal
D/AudioHardwareALSA(  867): Set PLAYBACK PCM format to S16_LE (Signed 16 
bit Little Endian)
D/AudioHardwareALSA(  867): Using 2 channels for PLAYBACK.
D/AudioHardwareALSA(  867): Set PLAYBACK sample rate to 44100 HZ
D/AudioHardwareALSA(  867): Buffer size: 16384
D/AudioHardwareALSA(  867): Latency: 371519

and this remains open. So the the lm is switch on on boot. I think that 
the correct behavior
is to have a different profile in asound.conf to avoid power drain and 
open a different one when
the system want to use the speaker or just not open the alsa device.

Hope that the now is clear

Best regards
Michael
