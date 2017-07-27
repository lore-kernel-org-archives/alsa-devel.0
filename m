From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH v2 0/3] ASoC: fix unbalanced
	of_node_get()/of_node_put()
Date: Fri, 28 Jul 2017 01:26:09 +0200
Message-ID: <20170727232612.23543-1-antonio.borneo@st.com>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F51726760D
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 01:33:15 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id 184so25472236wmo.3
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 16:33:15 -0700 (PDT)
In-Reply-To: <20170725214952.6491-1-borneo.antonio@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>, Antonio Borneo <borneo.antonio@gmail.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Antonio Borneo <borneo.antonio@gmail.com>

On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
errors at kernel boot, like
OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0
OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0/endpoint
each followed by stack dump.

Fixed by:
- removing of_node_put() in the body of of_for_each_phandle(){},
  since already provided at each iteration. Add it in case the
  loop is break out;
- adding of_node_get() before calling of_graph_get_port_parent().

Tested with kernel v4.13-rc2 with hikey_defconfig taken from
https://git.linaro.org/people/john.stultz/android-dev.git
branch dev/hikey-mainline-WIP

v1 -> v2:
- modify subject "s/fix balance of/fix unbalanced/";
- split the patch per each individual issue. It also simplify the
  backport;
- add ref to the commit being fixed;
- drop one fix not needed.

Antonio Borneo (3):
  ASoC: fix use of of_node_put() in of_for_each_phandle() loops
  ASoC: soc-core: fix unbalanced of_node_get()/of_node_put()
  ASoC: simple-card-utils: fix unbalanced of_node_get()/of_node_put()

 sound/soc/generic/audio-graph-card.c  | 9 ++++-----
 sound/soc/generic/simple-card-utils.c | 5 +++++
 sound/soc/soc-core.c                  | 5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
1.9.1
