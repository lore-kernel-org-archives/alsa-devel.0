From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/5] ctl: support extra information
	for user-defined element set
Date: Wed, 29 Jun 2016 22:42:58 +0900
Message-ID: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 21438266D8C
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 15:43:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds support extra information to the type-specific for
user-defined element set. Currently, 'dimension' is such an extra
information.

In ALSA kernel/userspace interface, information to an element is described
in this structure.

struct snd_ctl_elem_info {
    struct snd_ctl_elem_id id;
    unsigned int access;
    unsigned int count;
    pid_t owner;
    union value;

    union dimen;
    unsigned char reserved[64 - 4 * sizeof(unsigned short)];
};

This structure includes reserved fields, thus it's possible to add
more fields for future extension.

Currently, APIs to add user-defined element set don't support such extra
fields. Meanwhile, supporting just the dimension field is not good as
stable library APIs.

This patchset changes prototype of the APIs with 'snd_ctl_elem_info_t'
instead of adding more parameters. Callers are expected to fill the parameter
with identification information and the extra information.


Takashi Sakamoto (5):
  ctl: support extra information in user-defined element set
  ctl: add an API to set dimension levels to element information
  ctl: optimize a test for user-defined element set to older kernels
  ctl: optimize a test for user-defined element set to changes of APIs
  ctl: support dimension test for user-defined element set

 include/control.h           |  12 ++-
 src/control/control.c       | 219 +++++++++++++++++++++++---------------------
 src/pcm/pcm_softvol.c       |  10 +-
 test/user-ctl-element-set.c | 122 ++++++++++++++++++------
 4 files changed, 220 insertions(+), 143 deletions(-)

-- 
2.7.4
