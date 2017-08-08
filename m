From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH 0/3] Add support for playing a given number of
	samples
Date: Wed,  9 Aug 2017 01:05:57 +0300
Message-ID: <1502229960-8516-1-git-send-email-daniel.baluta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BC1D266AA9
 for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2017 00:06:15 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id x64so4817838wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 08 Aug 2017 15:06:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, alsa-devel@alsa-project.org
Cc: mihai.serban@nxp.com, shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@gmail.com>, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

We introduce (patch 1) the option of playing only a given number
of samples in order to reduce our simple test running time. Until
now we can only limit them at 1 second (-d parameter).

This patch series also refactors the playback function (patch 2) and
fixes a bug with small raw files (patch 3).

Previous discussions about this started here:

https://www.spinics.net/lists/alsa-devel/msg64463.html

Daniel Baluta (2):
  aplay: Refactor playback code
  aplay: Fix playback for small raw files

Ion-Horia Petrisor (1):
  aplay: Add samples argument for playing/recording a given number of
    samples

 aplay/aplay.c | 185 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 143 insertions(+), 42 deletions(-)

-- 
2.7.4
