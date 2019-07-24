From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 0/2 v2] Open Alsa dshare without channel binding
Date: Wed, 24 Jul 2019 12:12:58 +0200
Message-ID: <1563963180-416-1-git-send-email-amiartus@de.adit-jv.com>
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

The general idea of this patch is to be able to open the device without
defined bindings. As a result, it allows starting the audio clock of
underlying device without blocking a channel.

This might be useful for creating a dummy dsnoop pcm for hardware that
requires running clock early at system start. This clock is then present
even without application streaming audio data.

Patch n.1 is intended to check for null pointer of pcm callbacks,
it is not intended to alter any current functionality, properly defined
plugins should not suffer from this change

Patch n.2 is not intended to alter any current functionality, only
extend it

V2 of the patch, changes from V1:
  - instead of creating new "pcm_unsupported.c" with ops and fast_ops
    callbacks returning -ENOSYS, callback == NULL is checked directly
    in core implementation and error is returned when pcm has no
    callback defined

Adam Miartus (2):
  alsa: pcm: return -ENOSYS when ops or fast_ops callback is NULL
  alsa: dshare: allow missing bindings

 src/pcm/pcm.c        | 134 +++++++++++++++++++++++++++++++++++++++++----------
 src/pcm/pcm_dshare.c |  29 ++++++-----
 src/pcm/pcm_local.h  |  20 ++++++++
 src/pcm/pcm_mmap.c   |  15 ++++--
 src/pcm/pcm_params.c |  10 +++-
 5 files changed, 166 insertions(+), 42 deletions(-)

-- 
2.7.4
