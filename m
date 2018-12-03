From: GitHub pull_request - opened <github@alsa-project.org>
Subject: alsa-utils: axfer: use second argument for
	transmission direction
Date: Mon,  3 Dec 2018 13:00:09 +0100 (CET)
Message-ID: <20181203120009.904CE267A74@alsa0.perex.cz>
References: <1543838407615919113-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 231692678E4
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 13:00:07 +0100 (CET)
In-Reply-To: <1543838407615919113-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #4 was opened from takaswie:

This patchset is for axfer command in alsa-utils to use second argument 
for transmission direction. As a result, syntax of its command line is

  axfer subcommand direction options

For example:
$ axfer transfer playback [options]
$ axfer list capture [options]

This fashion requires more typing to users, however in my taste this
looks good because it's easier to understand than long/short options. 

Additionally, this patchset applies refactoring to list subcommand.

Takashi Sakamoto (5):
  axfer: apply refactoring to list subcommand for backward compatibility
    to aplay(1)
  axfer: apply refactoring in list subcommand for new command system
  axfer: use second argument in command line for transmission direction
  axfer: use transfer subcommand as a default for compatibility mode to
    aplay(1)
  axfer: truncate parsed arguments before operating subcommand

```
 axfer/main.c            | 100 +++++++++++++++++++++++++++++-----------
 axfer/subcmd-list.c     |  85 +++++++++++++++++++++++-----------
 axfer/subcmd-transfer.c |   7 ---
 3 files changed, 133 insertions(+), 59 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/4
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/4.patch
Repository URL: https://github.com/alsa-project/alsa-utils
