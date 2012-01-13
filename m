From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] cuse: implement memory mapping
Date: Fri, 13 Jan 2012 10:19:50 -0800
Message-ID: <CA+55aFy7xLkMThg8+G=e7v7x7WaHSkLWGRiRF8hCq4WEUHxymw@mail.gmail.com>
References: <1326474399-27278-1-git-send-email-miklos@szeredi.hu>
	<1326474399-27278-3-git-send-email-miklos@szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B4B9E244F9
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 19:20:12 +0100 (CET)
Received: by wibhm6 with SMTP id hm6so632755wib.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 10:20:11 -0800 (PST)
In-Reply-To: <1326474399-27278-3-git-send-email-miklos@szeredi.hu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: alsa-devel@alsa-project.org, htejun@gmail.com, mszeredi@suse.cz, gmane@colin.guthr.ie, linux-kernel@vger.kernel.org, smcnam@gmail.com, jamescaldwell1@gmail.com, linux-fsdevel@vger.kernel.org, s.maddox@lantizia.me.uk, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 13, 2012 at 9:06 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> From: Tejun Heo <htejun@gmail.com>
>
> This implements memory mapping of char devices.

I don't think this is how you want to do it.

It seems to maintain a page list of its own, and do the magic page
fault etc behavior. Which to me smells like a really bad design.

I would expect that what you actually want to do is to expose it as a
shared mmap, and depend on all the normal shmem support. Is there any
reason not to do that?

I guess you don't generally have big mappings, so an argument like
"that way you can page out pages etc" may not strike you as a very
strong argument, but I'd still prefer to at least see that approach
explored. Hmm?

                     Linus
