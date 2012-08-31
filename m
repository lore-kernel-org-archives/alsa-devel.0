From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Regression fixes for 3.5
Date: Fri, 31 Aug 2012 18:30:03 +0200
Message-ID: <5040E68B.4020800@gmail.com>
References: <1346345551-8956-1-git-send-email-zonque@gmail.com>
 <s5hy5kv3u4g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 19D9F26646A
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 18:30:08 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so1413295wib.2
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 09:30:07 -0700 (PDT)
In-Reply-To: <s5hy5kv3u4g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux@romal.de, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 31.08.2012 18:26, Takashi Iwai wrote:
> At Thu, 30 Aug 2012 18:52:28 +0200,
> Daniel Mack wrote:
>>
>> Here are 3 more regression fixes for snd-usb in 3.5. It's annoying
>> they haven't been found earlier, but at least we're now back to the
>> streaming quality we had before the streaming refactoring.
>>
>> Anyone with a USB device, please give it a quick shot at least.
> 
> I have no device right now during traveling, so ping me if you got a
> positive report or you tested by yourself.  Then I'll merge and send
> the pull request in the next week.

Well, I tested them extensively after I experienced the regressions when
stress-testing my devices under PureData with very low latencies. I'm
very sure all three fixes are correct. If you agree, just apply them.
But we can as well wait until next week. Maybe people find more time for
testing over the weekend :)


Thanks,
Daniel
