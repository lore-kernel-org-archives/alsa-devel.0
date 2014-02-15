From: Vincent Vinel <v.vinel@gmail.com>
Subject: [PATCH 0/1] dmix: Add support for S24_3BE format.
Date: Sat, 15 Feb 2014 17:54:30 +0100
Message-ID: <1392483271-20453-1-git-send-email-v.vinel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vincent Vinel <v.vinel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

This patch adds swapped versions for generic_(re)mix_areas_24() functions.
I am unsure if the same code could handle S24_BE properly, so this format
is left out and only S24_3BE is supported.

Thanks !

Vincent Vinel (1):
  dmix: Add support for S24_3BE format.

 include/pcm.h              |  4 +++
 src/pcm/pcm_direct.c       |  3 +-
 src/pcm/pcm_dmix.c         |  2 ++
 src/pcm/pcm_dmix_generic.c | 77 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 80 insertions(+), 6 deletions(-)

-- 
1.8.5.5
