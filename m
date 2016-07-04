From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH 0/3] Add audio support for Microsoft Surface 3
	tablet
Date: Sun,  3 Jul 2016 22:56:52 -0600
Message-ID: <20160704045655.31198-1-stephenjust@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Just <stephenjust@gmail.com>
List-Id: alsa-devel@alsa-project.org

This series adds audio support for the Surface 3 tablet.

This tablet identifes an rt5645 audio codec using the ACPI
identifer 10EC5640, which is already associated with the rt5640,
thus a quirk is required to have the correct drivers loaded.

Additionally, in order for jack-detection and the tablet's internal
microphone to work, the Surface 3 must be configured in the audio codec
driver similarly to other devices.

Resolves: https://bugzilla.kernel.org/show_bug.cgi?id=98001

UCM configuration to be added to alsa-lib is included in patch 3,
not included in the diffstat below.

Stephen Just (2):
  ASoC: rt5645: Add support for Surface 3 tablet
  ASoC: Intel: Atom: add quirk for CHT w/ RT5645

 sound/soc/codecs/rt5645.c               |  7 +++++++
 sound/soc/intel/atom/sst/sst_acpi.c     | 28 +++++++++++++++++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.7.4
