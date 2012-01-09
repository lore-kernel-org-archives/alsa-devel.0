From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH - ice1724 1/4] ALSA: ice1724 -
 Create	capture pcm only for ADC-enabled configurations
Date: Mon, 09 Jan 2012 10:53:29 +0100
Message-ID: <4F0AB919.40307@ivitera.com>
References: <1325797318-16333-1-git-send-email-pavel.hofman@ivitera.com>	<s5hboqemubc.wl%tiwai@suse.de>
	<4F0A9916.9050606@ivitera.com>	<s5hmx9xkyz6.wl%tiwai@suse.de>
	<4F0AB7DB.2010407@ivitera.com> <s5hhb05kxv1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 3EF39243D8
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 10:53:32 +0100 (CET)
In-Reply-To: <s5hhb05kxv1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 9.1.2012 10:51, Takashi Iwai napsal(a):
> At Mon, 09 Jan 2012 10:48:11 +0100,
> Pavel Hofman wrote:
>>
>> Dne 9.1.2012 10:27, Takashi Iwai napsal(a):
>>> At Mon, 09 Jan 2012 08:36:54 +0100,
>>> Pavel Hofman wrote:
>>>>
>>>>
>>>
>>> Ah, then I misunderstood your code.  The bit-wise operation is
>>> confusing for such a case.
>>>
>>> It should be rather more easy-readable like:
>>>
>>> 	if ((ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_ADC_MASK) ==
>>> 	    VT1724_CFG_ADC_NONE)
>>> 		capt = 0;
>>> 	else
>>> 		capt = 1;
>>>
>>> Could you revise the patch?
>>>
>>
>> Absolutely, happy to do so. Just please is there a way for me to
>> "migrate" from git.alsa-project.org to your repozitory at kernel.org
>> where the other patches were committed? I mean  without compiling the
>> whole kernel, just the drivers as with alsa-project.org? I followed the
>> description at
>> http://alsa-project.org/main/index.php/GIT_Server#Occasional_Developers
>> . The kmirror at git.alsa-project.org seems to be a bit behind.
> 
> You can build locally with alsa-driver-build.git.  This tree contains
> only the build stub.
> 
> 	% git clone git://..../sound.git
> 	% git clone git://..../alsa-driver-build.git
> 	% cd alsa-driver-build
> 	% utils/setup-alsa-kernel ../sound
> 	% ./gitcompile --enable-dynamic-minors ....
> 
> 

That helps a lot, thanks you.
