From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/24] ALSA: ctl: refactoring compat layer
Date: Sat, 25 Nov 2017 18:19:42 +0900
Message-ID: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 3EBCF266EDD
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

ALSA control core supports system call compatibility layer because some
structures in ALSA control interface includes members of 'long' and
'pointer' types and change own layout according to ABIs. In this point,
it's enough for the layer to have handlers for structures on ABIs with
'ILP32' data model.

A recent commit of 6236d8bb2afc ('ALSA: ctl: Fix ioctls for X32 ABI')
clear that System V ABI for i386 architecture is unique than the other
ABIs with 'ILP32' data model. On this ABI, machine type for storage class
of 'long long' type has 4 bytes alignment. This is different from the
other ABIs.

In current implementation of this layer, the same structure is used for
i386 ABI and the other ABI with 'ILP32' data model except for x32 ABI.
Macro is used to switch between these. But in a view of data model,
it's better to define structure for i386 ABI uniquely against the
other ABIs including x32 for simplicity.

Additionally, this layer includes some points to be improved:
 - cancel allocation in user space from kernel land
 - reduce kernel stack usage

This patchset is my attempts to improve the layer. For this purpose,
this patchset introduces a local framework to describe consistent method
to convert and process data for differences of structure layout.

Takashi Sakamoto (24):
  ALSA: ctl: introduce local framework to handle compat ioctl requests
  ALSA: ctl: add serializer/deserializer of 'elem_list' structure for
    32bit ABI compatibility
  ALSA: ctl: add serializer/deserializer of 'elem_info' structure for
    32bit ABI compatibility
  ALSA: ctl: add serializer/deserializer of 'elem_value' structure for
    modern 32 bit ABIs compatibility
  ALSA: ctl: add serializer/deserializer of 'elem_value' structure for
    i386 ABI compatibility
  ALSA: ctl: change prototype of local function for ELEM_LIST ioctl
  ALSA: ctl: add a helper function to allocate for ELEM_LIST request
  ALSA: ctl: cancel allocation in user space for ELEM_LIST request
  ALSA: ctl: unify calls of D0-wait function for ELEM_INFO request
  ALSA: ctl: unify calls of D0-wait function for ELEM_READ request
  ALSA: ctl: unify calls of D0-wait function for ELEM_WRITE request
  ALSA: ctl: allocation of elem_info data for ELEM_INFO request
  ALSA: ctl: change prototype of local function for ELEM_WRITE ioctl
  ALSA: ctl: change prototype of local function for ELEM_READ ioctl
  ALSA: ctl: allocation of elem_info data for ELEM_ADD/ELEM_REPLACE
    requests
  ALSA: ctl: add replace helper function to allocate own buffer
  ALSA: ctl: move removal code to replace helper function
  ALSA: ctl: replacement for compat ELEM_LIST operation for any 32 bit
    ABI
  ALSA: ctl: replacement for compat ELEM_INFO operation for any 32 bit
    ABI
  ALSA: ctl: replacement for compat ELEM_ADD operation for any 32 bit
    ABI
  ALSA: ctl: replacement for compat ELEM_REPLACE operation for any 32
    bit ABI
  ALSA: ctl: replacement for compat ELEM_READ/ELEM_WRITE operation for
    i386 ABI
  ALSA: ctl: replacement for compat ELEM_READ/ELEM_WRITE operation for
    modern 32 bit ABI
  ALSA: ctl: code cleanup for compat handler

 sound/core/control.c        | 242 ++++++++-----
 sound/core/control_compat.c | 837 +++++++++++++++++++++++++-------------------
 2 files changed, 630 insertions(+), 449 deletions(-)

-- 
2.14.1
