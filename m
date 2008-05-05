From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa pulse bugs
Date: Mon, 05 May 2008 11:31:13 +0100
Message-ID: <fvmnli$1t6$1@ger.gmane.org>
References: <20080505103410.zv8dezd9z44cksoc@dbservice.com>	<fvmi82$f7a$1@ger.gmane.org>	<20080505111126.lhtr3bwyo0sg4wc4@dbservice.com>	<fvmjd0$it8$1@ger.gmane.org>
	<fvmktt$ofl$1@ger.gmane.org>
	<20080505122210.sbwpuulog00cos4c@dbservice.com>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20080505122210.sbwpuulog00cos4c@dbservice.com>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pulseaudio-discuss@mail.0pointer.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tom@dbservice.com wrote:
>> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga0d9e14a4be65209eb549e48a9f07302
>>
>> Closest it says is: "It's positive and less than buffer size in normal
>> situation".
>>
>> So perhaps this is an invalid assumption at the wine side?
> 
> However this part:
> 
> Delay is distance between current application frame position and sound  
> frame position.
> 
> suggests that it indeed can be zero. Or why would a soundcard have a  
> gap between the read and write positions if it has played everything?

Indeed. I agree. However, for me this is something that should not be in 
high level documentation, that should be an internal thing (i.e. it's a 
detail of the implementation). It's perfectly true of hardware devices 
(no doubt the context when the docs were written) but perhaps this 
should not be true of non-h/w or ioplug based "devices"? Someone who 
vaguely understands the ALSA stuff should have a better insight on this 
to comment :p

>> Is there perhaps a more appropriate API call they can use to do whatever
>> test they are doing?
> 
> What Wine needs to know, is whether a particular sample has already  
> been played or not. It does 'bytes_written - delay_in_bytes' to find  
> out how much of the written data the soundcard has already played. If  
> there is a better test for it, please explain.

I've no idea, I'm just throwing up ideas/suggestions/opinions... there 
is little technical background from my comments, just trying to raise 
some points so people more familiar than I can comment :)

Take care

Col
