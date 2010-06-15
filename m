From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC 0/3] WM97xx AC97 GPIO support
Date: Tue, 15 Jun 2010 17:55:44 +0200
Message-ID: <1276617347-3522-1-git-send-email-manuel.lauss__13021.1256830536$1276617369$gmane$org@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Here's 3 patches which implement simple AC97 GPIO support to the WM97xx touch
drivers and the Alchemy (au1x) AC97 ASoC implementation.

Tested on Au1200 hardware with a WM9712 codec:  According to Mark Brown the
WM9712 only sets GPIOs when data is sent through slot 12, which prompted me
to implement this.

Thanks,
       Manuel Lauss


Manuel Lauss (3):
  sound: ac97: Add GPIO manipulation hooks
  input: wm97xx: set GPIOs with AC97 GPIO busops if implemented
  sound: asoc: au1x: implement AC97 GPIO access

 drivers/input/touchscreen/wm97xx-core.c |    5 +++-
 include/sound/ac97_codec.h              |    2 +
 sound/soc/au1x/psc-ac97.c               |   39 +++++++++++++++++++++++++++++-
 sound/soc/au1x/psc.h                    |    2 +
 4 files changed, 45 insertions(+), 3 deletions(-)

