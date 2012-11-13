From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: Races in alsa-lib with threads
Date: Tue, 13 Nov 2012 15:36:57 -0500
Message-ID: <CA+7tXijTmfKoaq=Cp0AxjT1zSUwN_A0gwKMi04y7rk1MsxnTow@mail.gmail.com>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de> <509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org>
 <s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
 <5175C6FEA820754B902FF6873E9285B00C985240@039-SN2MPN1-021.039d.mgd.msft.net>
 <s5h4nktipd5.wl%tiwai@suse.de>
 <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>
 <50A2AC48.7080206@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id ABD8C2615EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 21:36:58 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id fn1so7545481vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 12:36:57 -0800 (PST)
In-Reply-To: <50A2AC48.7080206@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Krakora Robert-B42341 <B42341@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 13, 2012 at 3:23 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Trent Piepho wrote:
>> Consider snd_pcm_writei(), most of the time is usually spent blocked
>> waiting for a period to elapse.  It is perfectly ok to call
>> snd_pcm_delay() during this time.  But if one isn't allowed to make
>> any other pcm calls during snd_pcm_writei() then this can't be done.
>
> Then use non-blocking mode.  Blocking mode is suitable only for
> applications that do not want to access the device while waiting.

So you get the same problem with snd_pcm_wait().  Or snd_pcm_drain().
Any alsa-lib function than can block will exclude other threads from
alsa-lib for much longer than necessary.
