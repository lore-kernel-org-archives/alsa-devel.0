From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: Re: problem linking pcm timer to midi timer at SB
	Audigy
Date: Fri, 25 Aug 2006 22:49:29 +0200
Message-ID: <44EF6259.7020904@gmx.net>
References: <44EF14F5.5000304@gmx.net>
	<1156520078.7520.269417316@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1156520078.7520.269417316@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

thanks for those infos!

Now I was experimenting with devices and subdevices and looked at
/proc/asound/seq/timer, see below.

Device 0 and Subdevice 0 is "PCM playback 0-0-0" with a period time of
0.000000000, so the queue is not advancing, which is the problem I
had.

Device 0 and Subdevice 1 is "PCM capture 0-0-1", and the queue is
running, but the Period time is 0.023219952, which is not what I set
with snd_pcm_hw_params (period_size=1024 -> period time = 0.00097656).
Am I forced to use another period size? (Unfortunately, at the moment I
only have internet access to that machine, so I cannot check the audio
recording.)

Device 0 and Subdevice 1 gives the "system timer", with a period time
of 0.004. Hmm...

Devices 2 and 4 doen't seem appropriate for timers.

Is there a way to get more infos or descriptions of subdevices?

Would you cleary recommend any of those devices/subdevices?

Many thx,
Gerald


 > arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Audigy2 [Audigy 2 Platinum [SB0240P]], device 0: emu10k1 [ADC 
Capture/Standard PCM Playback]
   Subdevices: 0/1
   Subdevice #0: subdevice #0
card 0: Audigy2 [Audigy 2 Platinum [SB0240P]], device 1: emu10k1 mic 
[Mic Capture]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Audigy2 [Audigy 2 Platinum [SB0240P]], device 2: emu10k1 efx 
[Multichannel Capture/PT Playback]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Audigy2 [Audigy 2 Platinum [SB0240P]], device 4: p16v [p16v]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

/proc/asound/seq/timer without linking:
Timer for queue 0 : RTC timer
   Period time : 0.000976562
   Skew : 65536 / 65536

/proc/asound/seq/timer with linking, device 0, subdevice 0:
Timer for queue 0 : PCM playback 0-0-0
   Period time : 0.000000000
   Skew : 65536 / 65536

/proc/asound/seq/timer with linking, device 0, subdevice 1:
Timer for queue 0 : PCM capture 0-0-1
   Period time : 0.023219952
   Skew : 65536 / 65536

/proc/asound/seq/timer with linking, device=1, subdevice 0:
Timer for queue 0 : system timer
   Period time : 0.004000000
   Skew : 65536 / 65536

/proc/asound/seq/timer with linking, device=2, subdevice 0:
Timer for queue 0 : PCM playback 0-2-0
   Period time : 0.000000000
   Skew : 65536 / 65536

/proc/asound/seq/timer with linking, device=4, subdevice 0:
Timer for queue 0 : PCM playback 0-4-0
   Period time : 0.000000000
   Skew : 65536 / 65536



Clemens Ladisch wrote:
> Gerald Grabner wrote:
>> I'm having troubles with linking the pcm timer to the midi timer for a
>> SB Audigy. I slightly adapted the code of Steve deRosier
>> [http://thread.gmane.org/gmane.linux.alsa.devel/22156/focus=22160], my
>> function is listed below. While it works with an ES1938 card, it
>> doesn't with a SB Audigy: If I'm trying to record audio (generated
>> from a midi signal I'm sending from the same card), I only hear the
>> first note sent. Obviously the timing is completely wrong. The problem
>> doesn't occur for pcm playback.
> 
> Look into /proc/asound/seq/queues and /proc/asound/seq/timers to see
> what's going on.
> 
>> Unfortunatly, I didn't find much documentation about cards, devices
>> and subdevices.
>> Do I have to choose a particular one for the Audigy?
> 
> Yes.  See "arecord -l" for a list of recording devices.  You have to
> choose the same device that you're using for recording.
> 
>> Why the "SDevice = SDevice << 1;" statement?
> 
> The subdevice number of the timer is not the same as the PCM subdevice
> number, see /proc/asound/timers.
> 
>> Where can I find documentation on this topic?
> 
> This stuff is basically undocumented.
> 
> 
> Regards,
> Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
