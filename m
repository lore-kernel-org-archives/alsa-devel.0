From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v6 0/3] ASoC: simple-card: Add multi-CODEC
	support
Date: Thu, 1 Jan 2015 09:54:14 +0100
Message-ID: <cover.1420102454.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id F144E260483
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 10:16:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set adds multi-CODEC support to the simple card.

v6: (Mark Brown)
	- don't stop unreferencing the codec nodes on null node
	- split the patch about simple-card.c
	- add example 3 in the DT binding
v5: accept only "sound-dai" as the dai link property (Arnd Bergmann)
v4: (Mark Brown)
	- document the new core function
	- calculation of the number of codecs moved to the core function
	- split the patch about simple-card.c
	- less code changes
	- remove the cast of pointers
	- less changes in the DT binding example 2
v3: rebase on broonie git 2014/11/03
v2: accept list of CODECs in 'sound-dais' (Benoit Cousson)

Happy New Year!

Jean-Francois Moine (3):
  ASoC: simple-card: prepare multi-CODECs
  ASoC: simple-card: Add multi-CODECs in DT
  ASoC: simple-card: Remove useless check

 .../devicetree/bindings/sound/simple-card.txt      | 19 ++++-
 sound/soc/generic/simple-card.c                    | 81 +++++++++++-----------
 2 files changed, 60 insertions(+), 40 deletions(-)

-- 
2.1.4
