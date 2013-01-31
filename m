From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/2] Fix thread safety issues
Date: Thu, 31 Jan 2013 12:38:29 +0100
Message-ID: <510A57B5.1000102@perex.cz>
References: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
 <s5hfw1i64k0.wl%tiwai@suse.de>
 <DBCAE20C-2070-4D0C-A7C0-E62D85846AD4@taodyne.com>
 <s5hwqutwx3z.wl%tiwai@suse.de>
 <712BEC00-37D2-458C-B8C1-A0EECBF6C608@taodyne.com>
 <s5hpq0lwtnw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B3E42602AC
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 12:38:30 +0100 (CET)
In-Reply-To: <s5hpq0lwtnw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 31.1.2013 11:09, Takashi Iwai wrote:
> Jaroslav, could you add some texts like below?  (Feel free to
> rephrase.)
> 
> "There are a few global variables that are used in alsa-lib, such as
>  the global error handler pointer and the global root config pointer.
>  Accessing / modifying these would be thread-unsafe."

Added.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
