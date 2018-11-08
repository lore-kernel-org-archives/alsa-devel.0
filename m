From: GitHub issues - opened <github@alsa-project.org>
Subject: High CPU usage in mpd
Date: Thu,  8 Nov 2018 09:11:51 +0100 (CET)
Message-ID: <20181108081151.59F55267AD3@alsa0.perex.cz>
References: <1541664708886255980-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 354BC2678F2
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2018 09:11:48 +0100 (CET)
In-Reply-To: <1541664708886255980-webhooks-bot@alsa-project.org>
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
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-utils issue #2 was opened from buttjake:

I've ran into a strange bug in mpd where I get really high cpu usage. All the details are in the following two short threads.
https://github.com/MusicPlayerDaemon/MPD/issues/391#issuecomment-435698235
https://bbs.archlinux.org/viewtopic.php?id=241722 ( buttcake is me )
I can also solve the bug by adding
```
audio_output {
 type	"alsa"
 device	"hw:0,0"
}
```
to the mpd.conf

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/2
Repository URL: https://github.com/alsa-project/alsa-utils
