From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 0/2] Fix thread safety issues
Date: Wed, 30 Jan 2013 16:22:15 +0100
Message-ID: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E99D264F8A
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 16:22:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jerome Forissier <jerome@taodyne.com>
List-Id: alsa-devel@alsa-project.org

This is a set of two patches to fix thread safety issues I found when running
a video application over ALSA. The application uses LibVLC to play several
videos simultaneously. LibVLC calls snd_pcm_open() and snd_device_name_hint()
from multiple threads, without locking--which is allowed according to
http://www.alsa-project.org/main/index.php/SMP_Design.

Without these patches, I would get random error messages like:

ALSA lib confmisc.c:768:(parse_card) cannot find card '$CARD'
ALSA lib conf.c:4184:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4184:(_snd_config_evaluate) function snd_func_concat returned error: No such device
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:4184:(_snd_config_evaluate) function snd_func_refer returned error: No such device
ALSA lib conf.c:4663:(snd_config_expand) Evaluate error: No such device

Jerome Forissier (2):
  Make snd_device_name_hint() thread-safe by locking a mutex
  snd_pcm_direct_parse_open_conf(): use thread-safe getgrnam_r()

 src/control/namehint.c | 31 +++++++++++++++++++++++++++++++
 src/pcm/pcm_direct.c   | 15 +++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

-- 
1.8.1.2
