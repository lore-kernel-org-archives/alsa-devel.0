From: Clemens Ladisch <clemens@ladisch.de>
Subject: [git pull] new HSS1394 MIDI back-end
Date: Sun, 11 Nov 2012 22:34:46 +0100
Message-ID: <50A019F6.1050101@ladisch.de>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>	<38538c62-f01e-4743-be92-aea79d61085e@email.android.com>	<4FC5AC47.4060606@mixxx.org>	<4FC5C9C8.1000604@ladisch.de>
 <4FC7CDC1.8020606@ladisch.de>	<4FD2F324.7070402@mixxx.org>
 <4FD32E76.3090304@ladisch.de> <4FD49A51.3050809@ladisch.de>
 <5087D5D2.6020208@mixxx.org> <508991BD.5090101@ladisch.de>
 <5090F6C7.5050401@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 88B792617AF
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 22:34:55 +0100 (CET)
In-Reply-To: <5090F6C7.5050401@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi, please pull the following change since commit
a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:

  Linux 3.6 (2012-09-30 16:47:46 -0700)

which is available in the git repository at:
  git://git.alsa-project.org/alsa-kprivate.git stanton-cs1-driver

Clemens Ladisch (1):
      ALSA: firewire: add Stanton SCS.1d/1m driver

 sound/firewire/Kconfig  |   13 ++
 sound/firewire/Makefile |    2 +
 sound/firewire/scs1x.c  |  527 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 542 insertions(+), 0 deletions(-)
 create mode 100644 sound/firewire/scs1x.c
