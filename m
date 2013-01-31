From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 0/3] Make snd_device_name_hint() reentrant
Date: Thu, 31 Jan 2013 15:47:22 +0100
Message-ID: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id D314C2615D2
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 15:47:37 +0100 (CET)
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

The following 3 patches ensure that snd_device_name_hint() does not mdify
any global variable. They fix spurious error messages that may occur when
the function is called from multiple threads simultaneously.

Jerome Forissier (3):
  Add snd_lib_error_set_local() to install a thread-local error handler.
  snd_device_name_hint(): do not change the global error handler.
  snd_device_name_hint(): do not use global snd_config.

 configure.in           | 10 ++++++++
 include/error.h        |  6 +++++
 src/control/namehint.c | 67 ++++++++++++++++++++++++++++----------------------
 src/error.c            | 24 +++++++++++++++++-
 4 files changed, 76 insertions(+), 31 deletions(-)

-- 
1.8.1.2
