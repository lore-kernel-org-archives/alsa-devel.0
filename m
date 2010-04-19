From: Shuang He <shuang.he@intel.com>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Mon, 19 Apr 2010 13:20:31 +0800
Message-ID: <4BCBE81F.6090606@intel.com>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 9699D103840
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 07:20:34 +0200 (CEST)
In-Reply-To: <20100419032856.GA13629@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>, pulseaudio-discuss@mail.0pointer.de, "Fu, Michael" <michael.fu@intel.com>, alsa-devel@alsa-project.org, "Bu, Long" <long.bu@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2010-4-19 11:28, Lennart Poettering wrote:
> On Wed, 14.04.10 15:56, Wu Fengguang (fengguang.wu@intel.com) wrote:
>
>    
>> Hi Lennart,
>>
>> We found that pulseaudio eats CPU ~19% CPU time, a little more than
>> mplayer when playing video. This is horrible for laptop batteries.
>>      
> This is not a particularly useful report.
>
> You know, this can have so many different reasons, the only thing I can
> really say, is that you can rest assured that it is not supposed to eat
> that much in normal use.
>
> The CPU usage of PA is primarily dependant of the latency requested by
> the clients. Low latency means high CPU load. Lower latency means higher
> CPU load. Try "pacmd list-sink-inputs" to figure out the latency the
> various applications requested.
>    
This is the output from "pacmd list-sink-inputs", when I'm playing the video
Welcome to PulseAudio! Use "help" for usage information.
 >>> 1 sink input(s) available.
     index: 0
         driver: <protocol-native.c>
         flags:
         state: RUNNING
         sink: 0 <alsa_output.pci-0000_00_1b.0.analog-surround-71>
         volume: 0: 100% 1: 100%
                 0: 0.00 dB 1: 0.00 dB
                 balance 0.00
         muted: no
         current latency: 444.25 ms
         requested latency: 31.25 ms
         sample spec: s16le 2ch 48000Hz
         channel map: front-left,front-right
                      Stereo
         resample method: speex-float-3
         module: 8
         client: 7 <ALSA plug-in [mplayer_2010_0414]>
         properties:
                 media.name = "ALSA Playback"
                 application.name = "ALSA plug-in [mplayer_2010_0414]"
                 native-protocol.peer = "UNIX socket client"
                 native-protocol.version = "16"
                 application.process.id = "2901"
                 application.process.user = "root"
                 application.process.host = "x-shuang"
                 application.process.binary = "mplayer_2010_0414"
                 application.language = "C"
                 window.x11.display = ":0.0"
                 application.process.machine_id = 
"9c81eadc677bd3522a68b7984ba753                                                                                                                               
08"
                 module-stream-restore.id = 
"sink-input-by-application-name:ALSA                                                                                                                                
plug-in [mplayer_2010_0414]"


Thanks
     --Shuang
> Then there can be driver problems, where the timing information is not
> entirely correct that ALSA passes on to, with the result that we get
> dropouts where we shouldn't, with the results that we shorten our sleep
> times, with the final effect that the CPU usage goes up.
>
> Of course, if PA is used resampling and suchlike is moved from the
> clients into the sound server and hence will be added to its CPU
> usage. And PA uses a better resampler by default than ALSA traditionally
> did, hence the CPU use will be a bit higher than plain ALSA.
>
> And then of course, the CPU usage depends on the CPU used. Is this some
> embedded hardware?
>
> In summary: if you want to know what is going on, you need a suitable
> tool, like a profiler and do the dirty work to figure out what is going
> on. Just saying "19%" is not helpful to figure out what is going on.
>
> On my machine here it uses 3% CPU while playing.
>
>    
>> Can we make it just work -- in green CPU mode?
>>      
> Yes, sure. If you use "pacat" you can play audio with almost zero CPU
> usage, because it is one of the few clients that actually asks for
> sensible latency (2s), which allows us to minimize the wakeup intervals
> to less than a second.
>
>    
>> I can find many users
>> complaining about this, and it seems like some fix is available in
>> this link:
>> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/207135
>>      
> Fix? Where?
>
> Lennart
>
>    
