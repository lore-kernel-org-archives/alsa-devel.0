From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 14:31:55 +0200
Message-ID: <50337FBB.4020709@perex.cz>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <s5hipcc30h4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE4C265F42
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 14:29:25 +0200 (CEST)
In-Reply-To: <s5hipcc30h4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Date 21.8.2012 14:15, Takashi Iwai wrote:
> For getting the channel map, the driver could send a notification once
> when routing is changed.

This leads to this question: Why you define the map controls volatile?
I think that the channel map changes can be tracked nicely using the
standard control event notifications without any hidden changes.
Perhaps, the value change event may be invoked each time after prepare
and when the user space set the new values and also in above situation,
when the channel map is changed on an external request.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
