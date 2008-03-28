From: Vova Barinov <vova.barinov@gmail.com>
Subject: Re: [Fwd: Re: Davinci ASoC support (patch)]
Date: Fri, 28 Mar 2008 19:13:14 -0400
Message-ID: <47ED7B8A.4030805@gmail.com>
References: <47ED0038.9020808@acdstar.com>
	<20080328150256.GA16855@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 00B4A2464E
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 17:12:55 +0100 (CET)
Received: by hu-out-0506.google.com with SMTP id 16so2735581hue.7
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 09:12:55 -0700 (PDT)
In-Reply-To: <20080328150256.GA16855@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lokowich <lokowich@acdstar.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Mar 28, 2008 at 09:27:04AM -0500, lokowich wrote:
>
>   
>> Forwarded from davinci-linux-open-source list:
>>     
>
> CCing in Vladimir Barinov who contributed the DaVinci support.
>
>   
>> I've built this ASoC patch into my DaVinci git kernel (thanks for the 
>> SENSORS tip), and can use aplay and speaker-test, but no sound.  Figured 
>> it may be a mixer/volume control issue, but the alsamixer is unable to 
>> open for a failed ioctl on USBDEVFS_IOCTL.  Not sure why there is a USB 
>> dependency.  Noted that there is no /sys/class/sound/mixer in my sysfs.  
>> Any ideas?
>>     
How do you figure out that you can play sound?
Also what platform do you use - is it Davinci-EVM? what line output do 
you use to hear the sound?
Please, post your dmesg log and cat /proc/interrupts too.
>
> It might be helpful to post dmesg output showing the sound support
> being loaded
>   
>> Bernard Blackham wrote:
>>     
>>> Behme wrote:
>>>   
>>>       
>>>> While searching something different, I just found
>>>>
>>>> http://www.spinics.net/lists/alsa-devel/msg12535.html
>>>>
>>>> As I'm not subscribed to alsa-devel, I don't have the original post. 
>>>> Maybe any of the authors can post it do this list as well?
>>>>
>>>> The patch mainly applies to our git. I fixed two small rejects in 
>>>> Kconfig and Makefile as the patch is for newer kernel than our git. 
>>>> Untested patch against our git in attachment. Anybody likes to test?
>>>>     
>>>>         
>>> Well, I tried compiling it and it failed to build. It appears that it's 
>>> built on a set of patches for Davinci posted to LAK, including this 
>>> completely revamped EDMA support[1]:
>>>
>>> http://www.spinics.net/lists/arm-kernel/msg47450.html
>>>       
Yep, it's needed.
>>> So I had to change a few definitions, import a few functions from the new
>>> DMA support and managed to get it compiling and loading, but not yet working
>>> (tried various sample rates and formats):
>>>
>>> root@davinci-dvevm:/tst$ aplay test.wav
>>> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>>> ALSA lib pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not usable
>>> aplay: set_params:878: Broken configuration for this PCM: no configurations
>>> available
>>>
>>> root@davinci-dvevm:/tst$ arecord -r 48000 -f S16_LE
>>> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
>>> ALSA lib pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not usable
>>> arecord: set_params:878: Broken configuration for this PCM: no
>>> configurations available
>>>
>>>
>>> And this is the extent of my knowledge of ALSA - I can continue digging, but
>>> maybe somebody else will beat me to it =) It's looking promising though.
>>>
>>> Attached is the patch I have so far that applies against current git. This
>>> is not for going upstream, but just for testing. Notes:
>>> - Apply patch
>>> - Enable SND_SOC, SND_DAVINCI_SOC, SND_DAVINCI_SOC_I2S, SND_DAVINCI_SOC_EVM
>>> and SND_SOC_TLV320AIC3X.
>>> - Make sure CONFIG_I2C_DAVINCI is enabled, but disable the
>>> CONFIG_SENSORS_TLV320* options.
>>> - Build.
>>> - Load the snd-soc-evm module.
>>>
>>> Bernard.
>>>
>>> [1] These patches appear to have gone absolutely nowhere beyond that list. I
>>> can't find them in any tree. But they are cleaner and more conforming to the
>>> Linux Kernel style than what's currently in git.
>>>
>>>   
>>> ------------------------------------------------------------------------
>>>
>>> _______________________________________________
>>> Davinci-linux-open-source mailing list
>>> Davinci-linux-open-source@linux.davincidsp.com
>>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>>   
>>>       
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>     
>
>   
