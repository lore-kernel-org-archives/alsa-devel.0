From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH - alsa-lib 0/4] Add pcm_file input file support
	for MMAP
Date: Tue, 21 May 2019 15:32:26 +0200
Message-ID: <1558445546-11437-1-git-send-email-amiartus@de.adit-jv.com>
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

implement overwriting read buffer with input file in case of
RW_NONINTERLEAVED and MMAP access modes for alsa file plugin

first two patches introduce a helper function for copying data from
input file to readi and readn buffers for user. to facilitate this
snd_pcm_areas_from_buf and snd_pcm_areas_from_bufs with
snd_pcm_areas_copy is used. Previous readi behaviour in corner
case of input file EOF is changed (more in patch comment).

Patch 3,4 introduce new api callback mmap_begin to ease overwritting
mmaped buffer in case of MMAP access.

Adam Miartus (4):
  pcm_file: add support for infile reading in non interleaved mode
  pcm_file: use snd_pcm_file_areas_read_infile for readi
  pcm: add mmap_begin callback to snd_pcm_fast_ops_t api
  pcm_file: add infile read support for mmap mode

 src/pcm/pcm.c           |   6 +++
 src/pcm/pcm_dmix.c      |   1 +
 src/pcm/pcm_dshare.c    |   1 +
 src/pcm/pcm_dsnoop.c    |   1 +
 src/pcm/pcm_file.c      | 125 ++++++++++++++++++++++++++++++++++++++----------
 src/pcm/pcm_generic.h   |   1 -
 src/pcm/pcm_hooks.c     |   1 +
 src/pcm/pcm_hw.c        |   2 +
 src/pcm/pcm_ioplug.c    |   1 +
 src/pcm/pcm_local.h     |   1 +
 src/pcm/pcm_meter.c     |   1 +
 src/pcm/pcm_mmap_emul.c |   1 +
 src/pcm/pcm_multi.c     |   1 +
 src/pcm/pcm_null.c      |   1 +
 src/pcm/pcm_plugin.c    |   1 +
 src/pcm/pcm_rate.c      |   1 +
 src/pcm/pcm_share.c     |   1 +
 src/pcm/pcm_shm.c       |   1 +
 18 files changed, 122 insertions(+), 26 deletions(-)

-- 
2.7.4
