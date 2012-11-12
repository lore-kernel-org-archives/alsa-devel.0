From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: snd_pcm_wait function
Date: Mon, 12 Nov 2012 15:57:50 -0500
Message-ID: <CA+7tXihDCpmvVpPCErz5WrZ8BtZTB+orp=W77dgXwwFsaX9eeQ@mail.gmail.com>
References: <50A0A3FE.4090901@tele2.nl>
	<50A0A709.1050307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4537126506E
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 21:57:51 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id fn1so6384455vbb.38
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 12:57:50 -0800 (PST)
In-Reply-To: <50A0A709.1050307@ladisch.de>
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
Cc: Enno Fennema <ennofennema@tele2.nl>, alsa-devel@alsa-project.org, daniellsanz2@gmail.com
List-Id: alsa-devel@alsa-project.org

You do have to fill to a full period before calling drain, or it won't
work in a very useful way.  It only stops when periods elapse.  So if
you have a half full period of audio at the end of the buffer you'll
get garbage when it plays to the end of that period before stopping.

On Mon, Nov 12, 2012 at 2:36 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Enno Fennema wrote:
>> I want to close the pcm AFTER the sound finished.
>
> Then close it after snd_pcm_drain() has returned.
>
>> The docs say calling drain() puts the pcm in the DRAINING state.
>
> It also waits until the device has drained (unless the device is in
> non-blocking mode).
>
>> When I obtain the state immediately after drain() it is already SETUP.
>> I hoped a state change from DRAINING to SETUP  would be the right time
>> to close the pcm but there appears to be no such state change.
>
> That change happens immediately before snd_pcm_drain() returns.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
