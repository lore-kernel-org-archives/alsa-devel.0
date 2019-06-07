From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 0/2] pcm_file write file assert case handling
Date: Fri, 7 Jun 2019 14:23:21 +0200
Message-ID: <1559910203-29795-1-git-send-email-amiartus@de.adit-jv.com>
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

patched possible case where failed file write can cause assert in pcm_file
plugin, by reporting error EPIPE and printing debug message.

reporting an error with debug hint message is preferred to assert, user
may have a way to recover in upper API level. providing a debug message
makes it easier to debug the issue from logs. previously, reaching assert
did not provide useful message to API level user.

Adam Miartus (2):
  pcm_file: do not disrupt playback on output file write fail
  pcm_file: report write output file error to api user

 src/pcm/pcm_file.c | 63 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 17 deletions(-)

-- 
2.7.4
