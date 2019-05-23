From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH - alsa-lib 0/1] pcm_file add missing unlock
Date: Thu, 23 May 2019 11:44:29 +0200
Message-ID: <1558604670-4180-1-git-send-email-amiartus@de.adit-jv.com>
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

previous patches:
	pcm: file: add support for infile reading in non interleaved mode
	pcm: file: use snd_pcm_file_areas_read_infile for readi

introduced an issue where pcm would not be unlocked on early return

Adam Miartus (1):
  pcm_file: add missing unlock on early return

 src/pcm/pcm_file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.7.4
