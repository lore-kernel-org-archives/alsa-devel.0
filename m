From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ALSA vs OSS: Some questions
Date: Mon, 07 Apr 2003 18:19:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E91B306.80208@superbug.demon.co.uk>
References: <20030407145029.GA19610@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030407145029.GA19610@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Frank Barknecht wrote:

>Hallo,
>
>I'm working on a Linux Audio article, where I also do provide a short
>comparison of ALSA vs. OSS. For this, because I'm in no way a hardware
>developer, I have some questions to make sure, I understand things
>correctly. Would someone with deeper insight in the OSS/ALSA internals
>help me and tell me, if the following assumptions are correct?
>
>I read, that OSS was hard to extent, for example to write drivers for
>modern hardware. Why is this so? 
>
>Is it, because OSS ties its model of programming too close to the
>hardware?
>
>Paul Davis said in its LAD keynot, that in the past we only had OSS
>and only had 16-bit interleaved stereo. From reading the OSS-developer
>docs, it seemed to me, that OSS does support more formats than 16-bit
>interl. stereo. So what can ALSA do in the format department, that OSS
>couldn't do?
>
>Can the ICE1712 chip server as an example for these difficulties? The
>ICE chip doesn't support CD-quality music (44.1 samplerate, 16-bit,
>stereo) in hardware, if I'm right? What format does it support? And
>how does ALSA help in getting this supported compared to OSS (which
>hasn't support for the ICE-cards)
>
>Thank you very much for your answers and facts.
>
>Regards,
>  
>
As an application developer, one of the main advantages of alsa is that 
all sound cards are supported with the entire alsa-lib api being valid 
and useable.
With OSS, different sound cards support different, so called optional, 
parts of the OSS specification. The problem is that as digital audio 
technology has advanced, more sample rates, multimedia requiring 
audio/video sync etc. applications need these optional OSS functions, 
but the application cannot be sure that all sound cards will perform as 
expected.
An example of this difference: -
alsa supports fully multi threaded audio applications.
some OSS drivers support it, some OSS drivers do not but there is no way 
for the multi-threaded audio application to tell.
So if the OSS driver supports multi-threading, no problems, but if the 
OSS driver does not, your application crashes!

 ALSA does have a major advantage over OSS, and that is that a lot of 
the code is shared between all the different sound cards. So, when one 
implements support for a new sound card, one can be fairly sure that is 
will function well, because only a small amount of hardware specific 
code has to be written. So if some new feature is added to the alsa-lib 
api, all sound cards automatically benefit from it. With OSS, each sound 
card has it's own driver code, without any shared code.

When ALSA detects that a sound card does not have a requested feature. 
E.g. Audio application wants 44.1khz but the sound card does not have 
it, ALSA can take several approaches.
1) snd_pcm_hw_params_set_rate() - on the hw interface : Deny the request 
forcing the application to try another rate and forcing the application 
to do sample rate conversion.
2) snd_pcm_hw_params_set_rate_near() - on the hw interface: Select a 
sample rate that it can do that is close to what the application wants 
and force the application to do sample rate conversion.
3) snd_pcm_hw_params_set_rate() - on the plug interface: Accept the 
request, and get ALSA to do all the sample rate conversion necessary.

OSS can only do (1).

Another nice thing about ALSA is that it's API is with friendly function 
calls.
OSS just uses IOCTL calls.

OSS has particularly bad api when it comes to multiple audio channels.
In ALSA you can open up 5 interleaved channels for audio and also decide 
which audio channel reaches which speaker.
For example, We might have 2 front, 2 rear and 1 center speaker
or 2 front, 2 rear and 1 subwoofer.
The user might have 6 speakers connected. 2 front, 2 rear and center and 
subwoofer.
So, with OSS you can select 5 interleaved channels, but you would have 
no idea where the 5th channel would come out of.
With OSS you would have to select 6-interleaved channels and get the 
application to move the data around to get the the data in the correct 
channls.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
