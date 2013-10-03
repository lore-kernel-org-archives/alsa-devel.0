From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: snd_device_name_hint segfaults
Date: Thu, 03 Oct 2013 22:16:17 +0200
Message-ID: <524DD091.6060105@canonical.com>
References: <20130626183909.GI18126@alittletooquiet.net>
 <s5hvc50xe9x.wl%tiwai@suse.de> <20130627143050.GK18126@alittletooquiet.net>
 <s5hli5voapl.wl%tiwai@suse.de> <20131003183623.GB29746@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3088E26007E
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 22:16:14 +0200 (CEST)
In-Reply-To: <20131003183623.GB29746@alittletooquiet.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Forest Bond <forest@forestbond.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/03/2013 08:36 PM, Forest Bond wrote:
>>>>> Here is the backtrace:
>>>>>
>>>>> #0  0x003f0e78 in __strcpy_chk () from /lib/i386-linux-gnu/libc.so.6
>>>>> #1  0x0625084b in strcpy (__src=0x0, __dest=0xb6025e80 "pcm.(null)") at /usr/include/i386-li
>>>>> nux-gnu/bits/string3.h:105
>>>>> #2  try_config (config=0xaf1c4df0, list=0xb52fe804, base=0x323e962 "pcm", name=0x0) at nameh
>>>>> int.c:243
>>>>> #3  0x06251bc5 in add_software_devices (list=0xb52fe804, config=0xaf1c4df0) at namehint.c:51
>>>>> 2
>>>>> #4  snd_device_name_hint (card=-1, iface=<optimized out>, hints=0xb52fe90c) at namehint.c:59

>> In general, the configuration space itself should be static,
>> determined at the loading time.
> 
> I've been meaning to follow up on this issue for a while.  Sorry for the delayed
> report.  We disabled PulseAudio idle exit and the problem went away, so it does
> appear to be related somehow.

Hi, a few weeks ago I came up with a related patch (based on an Ubuntu
bug report). This might be what you're looking for:

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=23bf1dce9438c0cf74357928289aa8f06957c283

When I fixed it, I thought it was just an edge case, but if this avoids
access violations in standard scenarios for you, VLC, mythtv, chromium,
and others - maybe we should try to make an update, even for stable
Ubuntu releases (such as Ubuntu 12.04)?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
