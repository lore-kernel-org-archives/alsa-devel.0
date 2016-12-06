From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v4 0/3] support DP MST audio
Date: Tue, 6 Dec 2016 02:58:21 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA69699@SHSMSX103.ccr.corp.intel.com>
References: <1480992519-108079-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ADEBC266686
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 03:58:27 +0100 (CET)
In-Reply-To: <1480992519-108079-1-git-send-email-libin.yang@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

The patchset is based on drm-tip branch in
git://anongit.freedesktop.org/drm-tip

Regards,
Libin


>-----Original Message-----
>From: Yang, Libin
>Sent: Tuesday, December 6, 2016 10:49 AM
>To: alsa-devel@alsa-project.org; tiwai@suse.de
>Cc: Lin, Mengdong <mengdong.lin@intel.com>; Yang, Libin
><libin.yang@intel.com>
>Subject: [alsa-devel] [PATCH v4 0/3] support DP MST audio
>
>From: Libin Yang <libin.yang@intel.com>
>
>This patchset starts to support DP MST audio.
>
>This patchset is based on drm-tip on
>git://anongit.freedesktop.org/drm-tip
>
>change log:
>v4: refine some comments in 0001 and 0002 patches.
>    refine the 0003 patch for the new ALSA-Configuration document
>
>Libin Yang (3):
>  ALSA: hda - add DP mst verb support
>  ALSA: hda - add DP MST audio support
>  ALSA: Documentation about HDA DP MST pin init and connection
>
> Documentation/sound/hd-audio/dp-mst.rst |  17 +++
> sound/pci/hda/hda_codec.c               |  76 +++++++++-
> sound/pci/hda/hda_codec.h               |   3 +
> sound/pci/hda/patch_hdmi.c              | 245 +++++++++++++++++++++++++------
>-
> 4 files changed, 285 insertions(+), 56 deletions(-)
>
>--
>2.7.4
