From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-utils][PATCH 0/9] alsactl: friendly to
	pluggable devices
Date: Sun, 14 Oct 2018 17:06:11 +0200
Message-ID: <dd076516-5fb2-4cdd-71f4-da433e6b52c8@perex.cz>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id AD4B32677F5
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 17:06:15 +0200 (CEST)
In-Reply-To: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 14.10.2018 v 16:36 Takashi Sakamoto napsal(a):
> Hi,
> 
> A bug was reported that monitor mode of alsactl consumes much CPU time
> after disconnection of any sound card[1].
> 
> This patchset improves the mode to handle connection/disconnection of
> sound card. Observed control nodes are maintained by list structure
> instead of array. Linux specific epoll(7) is used to dispatch events.
> Linux specific inotify(7) is used to detect connection of new sound
> card. Linux specific signalfd(2) is used to catch Unix signals for
> termination.

Thanks for your code. I reviewed this and applied to the alsa-utils git
repo.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
