From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] Fixes for the new generic parser
Date: Wed, 16 Jan 2013 11:45:34 +0100
Message-ID: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D3E8D2625F2
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 11:45:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I've run my hda-emu summary test tool to check for errors in the 110 
codecs we have of certified systems (those in codecs/canonical) 
against the test/hda-migrate branch.

After these fixes and the one I sent yesterday, there are no remaining
regressions (as seen by this test tool) compared to the current sound
tree.

David Henningsson (3):
  ALSA: hda - Check array bounds in get_input_path
  ALSA: hda - fix wrong adc_idx in generic parser
  ALSA: hda - initialize channel counts correctly

 sound/pci/hda/hda_generic.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
1.7.9.5
