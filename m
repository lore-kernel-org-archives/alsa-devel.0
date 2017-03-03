From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 00/10] ALSA SoC MAX98927 driver - revision
Date: Fri, 3 Mar 2017 23:52:38 +0900
Message-ID: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0135.outbound.protection.outlook.com [104.47.34.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C3F266AFE
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:53:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The initial driver had many textual and structural problems.
I have added next patches to modify existing problems.
There was concern about the design of keeping separate regmaps for each instance of the amplifier explicitly instead of instantiating two instances of a single, simpler driver.
This was major change of this release. Coding style problem like indentation also have been fixed.


Ryan Lee (10):
  ALSA SoC MAX98927 driver - Initial release
  Updated max98927_reg table with physical defaults. Replaced max98927.h
    for better legibility
  Removed the secondary device initialization from the primary device
    initialization. Removed manual register configuration from
    devicetree
  Modified indentation
  Replaced pr_err by dev_err. Modified debug message
  Added mask variable to apply it in one round after the switch
  Modified initialization code of VI sensing
  Added DAI Sel Mux and minor updates
  Added ACPI support. Changed snd_kcontrol_chip to
    snd_soc_kcontrol_codec
  Added vendor prefix. Added range information

 .../devicetree/bindings/sound/max98927.txt         |   39 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/max98927.c                        | 1039 ++++++++++++++++++++
 sound/soc/codecs/max98927.h                        |  267 +++++
 5 files changed, 1352 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/sound/max98927.txt
 mode change 100644 => 100755 sound/soc/codecs/Kconfig
 mode change 100644 => 100755 sound/soc/codecs/Makefile
 create mode 100755 sound/soc/codecs/max98927.c
 create mode 100755 sound/soc/codecs/max98927.h

-- 
2.7.4
