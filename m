From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] CS4270: comments: slave mode is now
	supported
Date: Sun, 8 Mar 2009 11:40:30 -0500
Message-ID: <ed82fe3e0903080940n4af2a4ffide7d44bd15bb22c8@mail.gmail.com>
References: <1236528963-11943-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BCFA1037F5
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 17:40:31 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so112090eyh.56
	for <alsa-devel@alsa-project.org>; Sun, 08 Mar 2009 09:40:30 -0700 (PDT)
In-Reply-To: <1236528963-11943-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 8, 2009 at 11:16 AM, Daniel Mack <daniel@caiaq.de> wrote:

> - * 3) Only Master mode is supported, not Slave.
> - * 4) The machine driver's 'startup' function must call
> + * 3) The machine driver's 'startup' function must call

I would have been simpler if you just said that both Master and Slave
mode is supported.  However, if you really want to delete #3, you may
as well get rid of all the numbers, so that we don't have to renumber
them again in the future.

> + * 6) The only supported control is volume and hardware mute (if enabled)

This is no longer true.  Pretty much all controls are now supported.
I should have changed that in my prior patch, but for now could you
just delete #6?  Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
