From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 0/3] pcm_file report EIO when fail to write to
	debug file
Date: Mon, 1 Jul 2019 15:25:15 +0200
Message-ID: <1561987518-2828-1-git-send-email-amiartus@de.adit-jv.com>
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

Previously, I introduced a patch that may return EPIPE error when pcm_file
plugin fails to write to output file for some reason.

The purpose of reporting the error was to evade assert in code to allow
API user error handling and recovery, or more clarity in debugging.

Failing to write to a file usually means bad file descriptor, running
out of free memory, insufficient file permissions or in case file
is a pipe there may be other reasons preventing the write operation.
All these are not easily recoverable by restaring playback as EPIPE
error which is used to signal XRUN might suggest. Therefore, use EIO
to signal a different kind of error.

write_wav_header function is refactored a bit for more detailed
error handling in case of failed write operation.

Adam Miartus (3):
  pcm_file: use EIO instead of EPIPE when failing to write output file
  pcm_file: improve error checking in write_wav_header function
  pcm_file: in case of failed write clear file buffer variables

 src/pcm/pcm_file.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 13 deletions(-)

-- 
2.7.4
