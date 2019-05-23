From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 0/2] add pcm_file support in MMAP read access
	mode
Date: Thu, 23 May 2019 15:00:38 +0200
Message-ID: <1558616440-21044-1-git-send-email-amiartus@de.adit-jv.com>
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

adds support for overwritting input buffer in MMAP access mode for
in pcm_file plugin

new api pcm_fast_ops callback mmap_begin is introduced to ease the
operation needed to overwrite mmaped buffer. this allows to modify
only the next continuous part of data in ring buffer.

Adam Miartus (2):
  pcm: add mmap_begin callback to snd_pcm_fast_ops_t api
  pcm_file: add infile read support for mmap mode

 src/pcm/pcm.c       |  6 ++++++
 src/pcm/pcm_file.c  | 31 +++++++++++++++++++++++++++++++
 src/pcm/pcm_local.h |  1 +
 3 files changed, 38 insertions(+)

-- 
2.7.4
