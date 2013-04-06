From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Sun, 07 Apr 2013 00:48:35 +0300
Message-ID: <51609833.3020806@sonarnerd.net>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
 <515E8105.9070607@gmail.com>
 <7.0.0.16.2.20130405092937.144d10d0@akdesigninc.com>
 <515F388D.4060707@sonarnerd.net> <515F39B9.90202@sonarnerd.net>
 <5160072E.8020500@gmail.com> <516060C1.9000101@sonarnerd.net>
 <5160624A.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D23265016
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 23:48:37 +0200 (CEST)
In-Reply-To: <5160624A.7070804@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

On 04/06/2013 08:58 PM, Daniel Mack wrote:
> ... and one frame is also just 8 bits (or 16, for the second format). I
> think that matches the logic quite well.

OK, so we agree. But what Andreas has in ASIO is sample rate at 2822400 
and periods actually contain period size number of bytes and thus period 
size * 8 samples. While for others periods actually contain period size 
number of samples and thus period size / 8 bytes (for DSD). Of course 
DSD64 doesn't do 2822400 bytes per second. It is either 2822400 bits per 
second, 352800 U8 per second, 176400 U16 per second or 88200 U32 per 
second. This keeps real sample (bit) rate of nbits(type)*sample rate == 
bit rate consistent.

So for U8 type and 2822400 DSD bit rate sample rate 352800. And for U16 
type 176400 sample rate. Now you can already see that for U8 type 
there's no overlap with any PCM hardware at least I'm aware of, but for 
U16 at 176400 there already is.

If we have DSD-specific sample types, the overlap is not a problem. If 
we don't and want to utilize UAC2 spec it matters more.
