From: Paul Davis <pbd@op.net>
Subject: Re: 1869 trouble with snd-es18xx
Date: Thu, 27 Jun 2002 10:54:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206271452.g5REqhD12507@post2.fast.net>
References: <3D1B1D7A.4070602@303.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 27 Jun 2002 16:13:14 +0200."
             <3D1B1D7A.4070602@303.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasper Souren <kasper@303.nu>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Paul Davis wrote:
>>>Isn't there any option to use a 'virtual' ALSA device? Like snd-pcm-oss, but
> 
>>>then the other way around. snd-oss-pcm module? Then you could use ALSA with 
>>>a working OSS driver, and no working ALSA driver...
>> 
>> 
>> ALSA has a significantly different internal architecture than OSS. It
>> is not possible to use an OSS driver to support the ALSA "midlevel"
>> code.
>
>What kind of "midlevel" code?

the code in alsa-kernel/core/pcm (for the audio side). this is
non-device-specific kernel side code. it is called by both user-space
code via system calls and by device-specific code via direct function calls.

>I meant an ALSA driver, that you can assign an OSS device. The "midlevel" 
>ALSA stuff can be handled by the ALSA driver, that just sends the audio data 
>to the OSS device.

you appear to be talking about routing audio data from alsa-lib to an
actual OSS device, and also providing a translation of the entire
alsa-lib audio API into OSS.

it doesn't seem very likely that anyone from the ALSA would want to do
this. the time could be much better spent on using an existing OSS
driver to implement a native ALSA one.

--p


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
