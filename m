From: GitHub issues - opened <github@alsa-project.org>
Subject: aplay - pcm_read: Input/output error
Date: Fri, 31 May 2019 14:00:53 +0200 (CEST)
Message-ID: <20190531120053.38561F896E5@alsa1.perex.cz>
References: <1559304050087626934-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E91E9F8072E
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 14:00:50 +0200 (CEST)
In-Reply-To: <1559304050087626934-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-lib issue #7 was opened from mrajwa:

Hello,

I came across an issue with custom built aplay (system one works OK on Ubuntu 18.04):

I have fetched both alsa-lib and alsa-utils repositories, built them now try to run:

`path_to_aplay/aplay -C -D hw:0,8 -r 16000 -f S16_LE -c 2 tmp.wav -vvv`

Immediately after the start it prints hw_params and the and error message saying:

`arecord: pcm_read:2103: read errorL Input/output error`

As I said system aplay works fine. Moreover I compared hw_params for both system and this custom built aplay and they are exactly the same!

I also tried to built alsa-utils from debian package here I did:

apt source alsa-lib && sudo apt build-dep alsa-utils && fakeroot debian/rules clean && fakeroot debian/rules build && fakeroot debian/rules binary

All finished fine, now I repeated above steps for alsa-utils and here is aproblem at fakeroot debian/rules binary step. At some point it stops with error message saying:

`dpkg-shlibdeps: error: no dependency information found for /usr/lib/libasound.co.s2 (used by debian/alsa-utils/usr/bin/alsaucm)`

Does anybody have any idea what is going on here?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/7
Repository URL: https://github.com/alsa-project/alsa-lib
