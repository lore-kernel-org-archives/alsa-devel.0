From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: HDA: Problem with sound becoming corrupted
Date: Thu, 10 Mar 2011 13:41:00 +1100
Message-ID: <AANLkTinP1ScPzoUqGbSdWRsUUiVhHSVBKvYkMtUKorq1@mail.gmail.com>
References: <il858r$kce$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C4AF5103803
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 03:41:03 +0100 (CET)
Received: by iym7 with SMTP id 7so1173920iym.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 18:41:01 -0800 (PST)
In-Reply-To: <il858r$kce$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On 10 March 2011 02:10, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> The problem is that the sound suddenly goes nuts and starts sounding
> awful. It's like some buffer pointer is just a little bit out for some
> reason.
>
> I can fix the issue by closing and reopening the PCM device (as I use
> PA, this is just a simple "pasuspender echo" away).


>
> The problem is very easy to reproduce - it happens about 20+ times a day
> to me - to the extent that I have added a panel launcher with the above fix.

I have to raise my hand on this one too... It has puzzled me for a few
months now.
I had thought it was related to the new video/audio card I'm using a
GT220 , but this is about the same time I upgraded alsa.

Every once in a while, the audio becomes slightly distorted. Voices
sounds like they are gargling with mouthwash while talking.

Interestingly, it sounds the same for AC3 or DTS passthrough, it's
slightly corrupted, but not enough to break the AC3 stream from being
usable by the amp.

However, closing the PCM device and re-opening it doesn't fix the
issue for me ; I need to reboot.

This is seen with MythTV using ALSA directly (I wrote the audio code in MythTV)

Few MythTV users have reported it, I can't explain what is causing it..

Jean-Yves
