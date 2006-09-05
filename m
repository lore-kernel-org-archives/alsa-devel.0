From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Tue, 05 Sep 2006 20:12:32 +0200
Message-ID: <44FDBE10.50008@p54A1A9D3.dip0.t-ipconnect.de>
References: <200609050321.k853L2l2031398@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609050321.k853L2l2031398@auster.physics.adelaide.edu.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

first of all, thank you for your explanations!


Jonathan Woithe wrote:

[...]

> The "pcm" control in alsamixer is not necessarily the same as the "pcm"
> interfaces I've been talking about.  Sorry for any confusion I've caused - I
> forgot about the alsamixer control labelled "pcm".  By pcm interface I'm
> referring to the "hw:0"/"hw:1"/"default"/"spdif"/etc designators one can use
> when specifying the output device for things like aplay.

Good to know :-). That's what I did last the latter. But now I know what
you meant by pcm.

> 
>> Now, I tested with aplay.
>> 
>> andreas@notebook1:~> aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
> 
> This is interesting.  Those on the list more knowledgeable than I might
> be able to correct me here, but I would interpret this to mean that
> "device 0" (ie: hw:0) is your analog output while device 1 (ie: hw:1)
> sends direct to the SPDIF channel on the ALC260.
> 
>> If I'm using aplay -D default, the output is analog. If I'm using -D
>> iec958 or spdif, there isn't any output. Btw.: using -D spdif or iec958
>> switches on the spdif switch in the mixer.
> 
> Right, so my interpretation of that is that in terms of the software,
> the "-D spdif" is probably doing the right thing in that the data is being
> sent to the SPDIF portion of the chip.  The fact that no SPDIF bitstream
> appears probably has something to do with external switching employed
> by your laptop which ALSA currently doesn't know about.
> 
> How are you testing for the existance of an SPDIF bitstream by the way?

Three ways:

1. Digital multimeter AC 200 mV - it always shows 0,0 V when the
S/PDIF-device is used. I'm expecting a nearly constant output.
2. external high end DA converter, which receives nothing.
3. an own small microprocessor, which is a gateway between coax and
optical output (in both directions) among other things.

[...]

> I didn't get a chance to look into this in greater detail over the weekend.
> However, given the extra information now provided I'll see about doing up
> a small test patch to test the GPIO theory.  If that turns out to work
> we can look into doing a permanent fix.

I would be very glad to test this patch! If you need more information,
please ask - I will try to provide them!


Thank you very much for your help,
kind regards,
Andreas Hartmann

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
