From: GitHub issues - opened <github@alsa-project.org>
Subject: when aplaymidi exits the sustained notes are played
	forever.
Date: Wed,  3 Jul 2019 22:08:32 +0200 (CEST)
Message-ID: <20190703200832.7EC66F800EA@alsa1.perex.cz>
References: <1562184509209604025-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F3DCEF800C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 22:08:29 +0200 (CEST)
In-Reply-To: <1562184509209604025-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-utils issue #22 was opened from mercuriete:

Transfered from here:
https://github.com/OpenTTD/OpenTTD/issues/7637

### Expected Result
All notes are stoped before exit aplaymidi

### Actual Result
Notes are sustained forever and I have to press the panic button on Qsynth

### Steps to Reproduce

1. Open Qsynth with fluid-soundfonts
2. do this: ```aplaymidi --port 128:0 file.mid```
3. do control+c to kill aplaymidi
4. Qsynth plays a note forever.

### Possible fix

Capture SIGINT and send midi off messages before exit properly.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/22
Repository URL: https://github.com/alsa-project/alsa-utils
