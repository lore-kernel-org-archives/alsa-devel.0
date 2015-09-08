From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 0/5] alsa-lib topology trivial fixes
Date: Tue,  8 Sep 2015 22:21:36 +0200
Message-ID: <1441743701-28165-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D72C9265128
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 22:21:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a series of trivial fixes that have been spotted by gcc
warnings.


Takashi

Takashi Iwai (5):
  topology: builder: Fix possibly uninitialized variable in
    write_elem_block()
  topology: ctl: Fix access type checks
  topology: data: Fix wrong size check in tplg_parse_data_hex()
  topology: parser: Add missing return value to
    snd_tplg_set_manifest_data()
  topology: pcm: Remove unused variables

 src/topology/builder.c | 9 ++++-----
 src/topology/ctl.c     | 2 +-
 src/topology/data.c    | 4 ++--
 src/topology/parser.c  | 1 +
 src/topology/pcm.c     | 3 +--
 5 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.5.1
