From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 0/2] expand dshare to allow audio clock when
	not streaming data
Date: Mon, 8 Jul 2019 13:04:47 +0200
Message-ID: <1562583889-2109-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The general idea of these changes is to be able to open the device without
defined bindings. This would start the audio clock without blocking a channel.

This might be useful for hardware that requires running clock early at
system start and to be available even without application streaming
audio data.

Andreas Pape (2):
  alsa: pcm: add unsupported OPS
  alsa: dshare: allow missing bindings

 src/pcm/Makefile.am       |   4 +-
 src/pcm/pcm_dshare.c      |  72 +++++++++++--
 src/pcm/pcm_unsupported.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_unsupported.h | 167 +++++++++++++++++++++++++++++
 4 files changed, 495 insertions(+), 13 deletions(-)
 create mode 100644 src/pcm/pcm_unsupported.c
 create mode 100644 src/pcm/pcm_unsupported.h

-- 
2.7.4
