From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: USB-Audio.conf routing and dmix
Date: Fri, 15 May 2015 10:58:11 +0500
Message-ID: <55558AF3.8070804@gmail.com>
References: <20150509002017.GB18945@freedom> <20150511195734.GA12233@freedom>
 <55531850.1020208@ladisch.de> <20150513113215.GA569@freedom>
 <20150515020715.GA418@freedom> <555589EF.60602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 09DE726154E
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 07:58:15 +0200 (CEST)
Received: by wgbhc8 with SMTP id hc8so67143914wgb.3
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 22:58:14 -0700 (PDT)
In-Reply-To: <555589EF.60602@gmail.com>
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

15.05.2015 10:53, Alexander E. Patrakov wrote:
> 15.05.2015 07:07, sylvain.bertrand@gmail.com wrote:
>> On Wed, May 13, 2015 at 11:32:15AM +0000, sylvain.bertrand@gmail.com
>> wrote:
>>> On Wed, May 13, 2015 at 11:24:32AM +0200, Clemens Ladisch wrote:
>>>>>> I linked the surround51 and surround71 pcms with the
>>>>>> 'disable-able' dmix
>>>>>> section from the default pcm.
>>>>
>>>> These devices are not supposed to use plug or dmix.
>>>
>>> Ok. Then, there is no pcm to output 5.1 sound with dmix.
>>>
>>> Does it mean that the application is in charge to build a alsa-lib
>>> pipeline
>>> with dmix pcm and surround51 pcm, in order to let other applications
>>> output 5.1
>>> sound at the same time?
>>
>> Then what is the "Right"(tm) way to do that?
>>
>
> [this is my personal opinion, in no way official]
>
> The right way seems to be to use PulseAudio. Pure ALSA, in its default
> configuration, just does not support mixing 5.1 audio, on any card. This
> default cannot really be changed, because there are many people who use
> 5.1 cards for output to stereo headphones only, i.e. who need automatic
> downmixing if an app (such as VLC) starts a 5.1 stream. The default
> plug/dmix setup provides such downmixing.

I need to test things before posting. This is wrong, plug/dmix does not 
include the extra channels in the stereo mix.

> As an application developer, just tell your users "your default device
> needs to support 5.1, see you there", as mpv developers did. This will
> be the case either with PulseAudio or with a hacked .asoundrc.

This is still my position.

-- 
Alexander E. Patrakov
