From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Correct rx format
 unit configuration
Date: Wed, 14 Jan 2015 12:11:00 +0100
Message-ID: <54B64EC4.6040600@gmail.com>
References: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 28A9F261B28
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 12:11:03 +0100 (CET)
Received: by mail-wg0-f42.google.com with SMTP id k14so8232205wgh.1
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 03:11:02 -0800 (PST)
In-Reply-To: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: peter.ujfalusi@ti.com
List-Id: alsa-devel@alsa-project.org

Hey Peter, all,

the patch (8e3006d02b46a722729a3bbd6a774eae99c6c8b8), causes lots of
terrible noise on a custom built am33xx based board, if I map the input
to the output like so:

arecord -f S16_LE -r 48000 -c2 -D hw:0,1 -F 0 --period-size=102
4 -B 0 --buffer-size=4096 | aplay -D hw:0,0 -

If I undo your changes, everything works fine. Tested with 3.14.23 and
3.18.1.

Do you have any Idea, what might cause that behavior?


regards,
pascal
