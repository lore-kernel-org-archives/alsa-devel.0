From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: USB-Audio.conf routing and dmix
Date: Fri, 15 May 2015 10:53:51 +0500
Message-ID: <555589EF.60602@gmail.com>
References: <20150509002017.GB18945@freedom> <20150511195734.GA12233@freedom>
 <55531850.1020208@ladisch.de> <20150513113215.GA569@freedom>
 <20150515020715.GA418@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 25FA22615C0
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 07:53:55 +0200 (CEST)
Received: by wicnf17 with SMTP id nf17so123199257wic.1
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 22:53:54 -0700 (PDT)
In-Reply-To: <20150515020715.GA418@freedom>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sylvain.bertrand@gmail.com, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

15.05.2015 07:07, sylvain.bertrand@gmail.com wrote:
> On Wed, May 13, 2015 at 11:32:15AM +0000, sylvain.bertrand@gmail.com wrote:
>> On Wed, May 13, 2015 at 11:24:32AM +0200, Clemens Ladisch wrote:
>>>>> I linked the surround51 and surround71 pcms with the 'disable-able' dmix
>>>>> section from the default pcm.
>>>
>>> These devices are not supposed to use plug or dmix.
>>
>> Ok. Then, there is no pcm to output 5.1 sound with dmix.
>>
>> Does it mean that the application is in charge to build a alsa-lib pipeline
>> with dmix pcm and surround51 pcm, in order to let other applications output 5.1
>> sound at the same time?
>
> Then what is the "Right"(tm) way to do that?
>

[this is my personal opinion, in no way official]

The right way seems to be to use PulseAudio. Pure ALSA, in its default 
configuration, just does not support mixing 5.1 audio, on any card. This 
default cannot really be changed, because there are many people who use 
5.1 cards for output to stereo headphones only, i.e. who need automatic 
downmixing if an app (such as VLC) starts a 5.1 stream. The default 
plug/dmix setup provides such downmixing.

Those who actually have a 5.1 system and need to opt out of this 
downmixing must actively do it (both with ALSA and with PulseAudio). For 
PulseAudio, it is as simple as starting pavucontrol and selecting a 5.1 
output profile for the relevant card. For ALSA, a config has to be 
created from scratch. On some cards, the config suggested by mpv 
developers works:

https://github.com/mpv-player/mpv/wiki/ALSA:-Surround-Sound-and-Upmixing

As an application developer, just tell your users "your default device 
needs to support 5.1, see you there", as mpv developers did. This will 
be the case either with PulseAudio or with a hacked .asoundrc.

OTOH, I will be happy to review a patch that makes the dmix channel 
count configurable on a per-card basis in .asoundrs in a way similar to 
the rate. But that's hard - you will have to change all card configs, 
and implement some conditional blocks because some cards expose 
themselves as several stereo devices, so you want a multi plugin on 
several instances of dmix then.

-- 
Alexander E. Patrakov
