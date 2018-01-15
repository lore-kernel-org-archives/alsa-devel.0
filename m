From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Maximum 50 dB gain in ALSA softvol plugin
Date: Mon, 15 Jan 2018 15:32:53 +0100
Message-ID: <286af449-5a35-5271-2a51-6a8f98a0a916@perex.cz>
References: <alpine.DEB.2.11.1801121645540.16471@lnxricardw1.se.axis.com>
 <s5ha7xj3ug4.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151410060.2359@lnxricardw1.se.axis.com>
 <s5hd12b2q99.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151446420.2359@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 0902B26753A
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 15:32:57 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1801151446420.2359@lnxricardw1.se.axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 15.1.2018 v 14:49 Ricard Wanderlof napsal(a):
> 
> On Mon, 15 Jan 2018, Takashi Iwai wrote:
> 
>>> Ok, my suggestion would be set MAX_DB_UPPER_LIMIT to 90 dB. 90 dB comes 
>>> out as 31622, which still is manageable when shifted up by VOL_SCALE_SHIFT 
>>> (= 16), fitting in a 32-bit int. Thus it works in MULTI_DIV_short() too, 
>>> where it is multiplied with the 16-bit sample value yielding an int.
>>>
>>> I'll try it out and prepare a patch.
>>
>> Well, but +90dB gain doesn't look like a normal usage pattern. Why do 
>> you have to use softvol plugin for achieving that specific purpose?
> 
> The usecase we have actually calls for 55 dB of gain maximum, but I was 
> thinking that looking at the code the maths can actually handle 90 dB so 
> it would be good 'reasonable limit' - it's a nice round number and fits in 
> 16 bits (signed).
> 
> The usecase we have is using digital MEMS microphones ((2S connected, 
> with no integral amplification) and when the sound source is far away, a 
> fair amount of gain can be needed.

Wow, the signal quality from few bits per sample must be really good ;-)
It would be better to use ADC with higher resolution (24-bit) and low
noise floor (but I see the possible costs requirements). This is why we
have such good audio in collaborative conferences :-)

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
