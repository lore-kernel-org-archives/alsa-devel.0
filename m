From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Races in alsa-lib with threads
Date: Tue, 13 Nov 2012 21:23:36 +0100
Message-ID: <50A2AC48.7080206@ladisch.de>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de> <509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org> <s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
 <5175C6FEA820754B902FF6873E9285B00C985240@039-SN2MPN1-021.039d.mgd.msft.net>
 <s5h4nktipd5.wl%tiwai@suse.de>
 <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 52B3F2615EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 21:23:51 +0100 (CET)
In-Reply-To: <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Krakora Robert-B42341 <B42341@freescale.com>
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> Consider snd_pcm_writei(), most of the time is usually spent blocked
> waiting for a period to elapse.  It is perfectly ok to call
> snd_pcm_delay() during this time.  But if one isn't allowed to make
> any other pcm calls during snd_pcm_writei() then this can't be done.

Then use non-blocking mode.  Blocking mode is suitable only for
applications that do not want to access the device while waiting.


Regards,
Clemens
