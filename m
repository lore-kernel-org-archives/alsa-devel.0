From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 0/2] v2 pcm_file propagate write error instead
	of an assert
Date: Wed, 12 Jun 2019 08:48:26 +0200
Message-ID: <1560322108-17074-1-git-send-email-amiartus@de.adit-jv.com>
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

patch possible case whenre file write causes assert in pcm_file
plugin, by reporting error to user and printing a message

user has a chance to recover error state, or capture
correct logs before assert happens, and may have an idea how
to recover

Adam Miartus (2):
  pcm_file: do not disrupt playback on output file write fail
  pcm_file: report write output file error to api user

 src/pcm/pcm_file.c | 61 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 18 deletions(-)

-- 
2.7.4
