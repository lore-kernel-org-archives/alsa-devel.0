From: apatard@mandriva.com
Subject: [patch 0/6] kirkwood openrd client audio support - v2
Date: Sat, 15 May 2010 17:29:58 +0200
Message-ID: <20100515152958.899927802@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 0C87A24383
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 17:31:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, nico@fluxnic.net, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

[ added forgotten linux-arm-kernel cc: ]

Hi,

It's a new try to get merged support for openrd client audio.
I've tried to fix all comments, I hope I didn't miss something.

In the changes, there's :
- s/kirkwood/orion/
- Added a comment about data centered around 0 in the new control entry
- fixed quilt diffstat header braindamage
- added dapm support to cs42l51 codec
- use ASoC register cache support
- modified i2s driver to be a platform driver and move resource stuff to
  the right place


Arnaud Patard
