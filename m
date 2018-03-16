From: <twischer@de.adit-jv.com>
Subject: [PATCH - IOPLUG] Update prepare and draining state
	correctly
Date: Fri, 16 Mar 2018 11:02:53 +0100
Message-ID: <1521194574-20196-1-git-send-email-twischer@de.adit-jv.com>
References: <s5h605x72zh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C9B32267380
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 11:03:03 +0100 (CET)
In-Reply-To: <s5h605x72zh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

> Yes, these are very trivial changes.

See attached the required patch for the IO plug API.

> Well, but your internal state copy is also not thread safe as of this
> patch, after all.

I will introduce additional variables for the synchronisation between the
JACK thread and ALSA thread with the thread safety patches.


Best regards

Timo
