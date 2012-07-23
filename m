From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using MMAP feature
Date: Mon, 23 Jul 2012 16:46:44 +0200
Message-ID: <500D63D4.10202@ladisch.de>
References: <500CF994.5090901@seletech.com> <500D29A3.50204@ladisch.de>
 <500D40D5.6050606@seletech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2E5B0265D02
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 16:46:44 +0200 (CEST)
In-Reply-To: <500D40D5.6050606@seletech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alberto Villa <a.villa@seletech.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't drop the mailing list)
(please configure your mailer to wrap lines)

alberto Villa wrote:
> Il 23/07/2012 12:38, Clemens Ladisch ha scritto:
>> alberto Villa wrote:
>>> Hello,
>>> I'm going to use the MMAP feature of ALSA.
>>
>> Why do you need to do this?
>
> I need to use MMAP because we are running on an embedded system and we
> want to optimize its operations.

What exactly do you want to optimize?  In most cases, mmap is no faster
than snd_pcm_write; using mmap make sense only if the samples are
generated dynamically without storing them in a userspace buffer.

> It was necessary to use snd_pcm_wait() before snd_pcm_begin(), may be
> this the reason?

If you never wait, the buffer will be filled eventually.


Regards,
Clemens
