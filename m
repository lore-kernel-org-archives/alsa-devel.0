From: Timur Tabi <timur@freescale.com>
Subject: Re: Can DMA address, periods, buffer size,
	etc change 	after hw_params is called?
Date: Thu, 29 Jan 2009 16:30:11 -0600
Message-ID: <ed82fe3e0901291430x1186e9b7h836a743daadbb772@mail.gmail.com>
References: <20090129081825.241be9e4@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f20.google.com (mail-qy0-f20.google.com
	[209.85.221.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E09103884
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 23:30:12 +0100 (CET)
Received: by qyk13 with SMTP id 13so271276qyk.8
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:30:11 -0800 (PST)
In-Reply-To: <20090129081825.241be9e4@hcegtvedt>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 29, 2009 at 1:18 AM, Hans-Christian Egtvedt
<hans-christian.egtvedt@atmel.com> wrote:

> Should I after the open and hw_params calls be ready to handle any
> change at all regarding DMA buffer address, periods and/or number of
> periods?

You would need to do this, if you allocate your DMA buffer in the
hw_params function.  However, I recommend that you allocate it in the
_new/_open function instead (I can't remember what it's called) for
the maximum size possible, and in _hw_params, just remember what the
size is supposed to be.  That way, you won't need to free/realloc your
DMA buffer.  Trust me, it's a lot easier this way.

Take a look at commit bf9c8c9ddef7ef761ae9747349175adad0ef16ce, where
I modify my driver to move the DMA allocation from _hw_params to
_open.

-- 
Timur Tabi
Linux kernel developer at Freescale
