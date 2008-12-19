From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: ice1712 error
Date: Fri, 19 Dec 2008 17:00:43 +0100
Message-ID: <494BC52B.8020605@xs4all.nl>
References: <494BC00A.9080202@xs4all.nl> <s5hocz8uq0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr19.xs4all.nl (smtp-vbr19.xs4all.nl [194.109.24.39])
	by alsa0.perex.cz (Postfix) with ESMTP id C18D624431
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 17:00:44 +0100 (CET)
In-Reply-To: <s5hocz8uq0t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> ICE1712: probe of 0000:01:09.0 failed with error -12
>> Does this mean the card is toast?
>> What does the -12 mean?
> 
> It's ENOMEM, means it failed to allocate some memories.

Thanks for the info.

There is 4G of RAM in the box.
I can boot with mem=2048000K and still get the error every like I 
described. (sometimes it is in error, sometimes it is OK)

Do I need to remove SIMMs to test?

What could I do?
