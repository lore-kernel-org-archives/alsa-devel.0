From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: using plug for sample format conversion
Date: Tue, 24 Aug 2010 11:17:33 -0400
Message-ID: <AANLkTimHu1QqsTwM8zQ1cz2ho-aym3h4_tv0hz0bRi2n@mail.gmail.com>
References: <AANLkTik=MskE7rGhBmuyDtJTe5BAie7AckiANrheJ8Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5151C24382
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 17:17:34 +0200 (CEST)
Received: by vws20 with SMTP id 20so6295851vws.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 08:17:33 -0700 (PDT)
In-Reply-To: <AANLkTik=MskE7rGhBmuyDtJTe5BAie7AckiANrheJ8Qi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a few other things going on at the office but here is a month
late status to close out this thread:

I see now that it fails with S16_LE because of this:

ACCESS = 0000000000000007 -> 0000000000000000

when it works using S32_LE is shows this:

ACCESS = 0000000000000008 -> 0000000000000008

because of this issue I decided to implement S16_LE support in my
driver directly.  This turned out to just be a workaround though as
the real problem seems to be in the organization of the actual driver.
 I will send a separate message to alsa-devel about this.

Thanks,
Adam
