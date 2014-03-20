From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PARTIAL PATCH 0/3] ASoC: simple-card: multi DAI links
	extension
Date: Thu, 20 Mar 2014 11:55:25 +0100
Message-ID: <cover.1395312925.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 813C2265205
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 12:06:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch series extends the simple card driver to handle
many DAI links as this exists in the Cubox audio subsystem.

** this is a partial patch **

Jyri, is this OK as a base for you?

- partial patch
	- remove 'simple-card: Simplify code'
		which is applied (Mark Brown)
	- add a DAI link container in the DT

- v3
	- remove 'Fix the reference count of device nodes'
		which is applied (Mark Brown)
	- new patch 'Simplify code'
	- dynamically allocate and use properties for all DAI links
		(Jyri Sarha and Li Xiubo)
- v2
	- change subject/comment about device node reference count
		(Mark Brown)
	- use a null size array instead of an implicit area for the DAI links
		(Li Xiubo)
	- update the reference count of the device node at end of probe

Jean-Francois Moine (3):
  ASoC: simple-card: dynamically allocate the DAI link and properties
  ASoC: simple-card: Add DT documentation for multi-DAI links
  ASoC: simple-card: Handle many DAI links

 .../devicetree/bindings/sound/simple-card.txt      |  42 +++-
 sound/soc/generic/simple-card.c                    | 220 +++++++++++++--------
 2 files changed, 183 insertions(+), 79 deletions(-)

-- 
1.9.1
