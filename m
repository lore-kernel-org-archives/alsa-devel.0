From: melwyn lobo <linux.melwyn@gmail.com>
Subject: Re: XRUN handling
Date: Tue, 6 Jul 2010 16:35:21 +0530
Message-ID: <AANLkTimKA4B8qxbUhlE_3CpCaDOVCS_MpglOiERqS4zS@mail.gmail.com>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<4C32CD2F.2010100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id A3B8E243FB
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 13:05:24 +0200 (CEST)
Received: by vws9 with SMTP id 9so3828571vws.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2010 04:05:22 -0700 (PDT)
In-Reply-To: <4C32CD2F.2010100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adding mailing list to copy:

- Hide quoted text -
> melwyn lobo wrote:
>> In case snd_pcm_playback_avail() is less than stop threshold but
>> greater than 0, then these bytes are missing after Xrun prepare and
>> start stage.
>
> Preparing a stream resets it, i.e., any data currently in the buffer
> is discarded.
>
> If you want to have data in the buffer after preparing, you have to
> write it again.
>


Thanks for the confirmation. Our client is working on aplay to test
our driver in which already there is this issue.
Is there any workaround in kernel/driver space that could be done or
it can only be fixed in aplay.

Regards
M.
