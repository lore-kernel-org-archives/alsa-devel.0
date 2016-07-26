From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/3] ASoC: topology: Add support for BE DAIs
Date: Tue, 26 Jul 2016 14:31:28 +0800
Message-ID: <cover.1469514328.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6774253742514217413=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AF010261B01
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 08:26:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

--===============6774253742514217413==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is topology ABI udpate in this series. Topology core can check size
of each ABI objects to detect version mismatch between user space and
kernel.

This series adds support for BE (Back End) DAIs:
- Define the type and ABI struct for Backend DAIs.
- The topology core can configure an existing BE DAI or create new BE
  DAIs.

The user space series "topology: Add support for BE DAIs" is also
submitted.

There will be 2 pairs of kernel & user space series for PCM & BE links
later.

History:
v2: Remove unused argument to fix the compiler warning.
    sound/soc/soc-topology.c: In function =E2=80=98soc_tplg_be_dai_config=
=E2=80=99:
    sound/soc/soc-topology.c:1789:22: warning: too many arguments for for=
mat [-Wformat-extra-args]
    dev_err(tplg->dev, "ASoC: Invalid BE DAI name\n",


Mengdong Lin (3):
  ASoC: topology: ABI - Add the types for BE DAI
  ASoC: topology: Add support for configuring existing BE DAIs
  ASoC: topology: Able to create BE DAIs

 include/sound/soc-topology.h |   1 +
 include/uapi/sound/asoc.h    |  34 +++++++++-
 sound/soc/soc-core.c         |   3 +-
 sound/soc/soc-topology.c     | 155 +++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 188 insertions(+), 5 deletions(-)

--=20
2.5.0


--===============6774253742514217413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6774253742514217413==--
