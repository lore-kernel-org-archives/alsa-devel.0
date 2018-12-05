From: GitHub pull_request - opened <github@alsa-project.org>
Subject: axfer: check whether a terminal is referred for stdio
Date: Wed,  5 Dec 2018 03:08:39 +0100 (CET)
Message-ID: <20181205020840.96212267BCC@alsa0.perex.cz>
References: <1543975713111123085-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 69EF7267B88
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 03:08:33 +0100 (CET)
In-Reply-To: <1543975713111123085-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #5 was opened from takaswie:

A reference to a terminal for standard input/output brings some
troubles. For capture transmission, it can bring some terminal
control codes and it's possible to make the terminal in disorder.
For playback transmission, it can bring endless loop to read
data for detection of type of container.

This commit checks whether a terminal is referred for the standard
input/output by a call isatty(3). When detecting a terminal,
axfer run time prints message and goes to finish.

Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/5
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/5.patch
Repository URL: https://github.com/alsa-project/alsa-utils
