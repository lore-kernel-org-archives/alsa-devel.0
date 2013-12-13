From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Where to find recent fix for HD-Audio runtime PM?
Date: Fri, 13 Dec 2013 14:30:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801437B35@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CAF82616F3
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 15:30:12 +0100 (CET)
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
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

If convenient, would you please point out your previous patches to make HD-Audio runtime PM stable?
I guess 'ALSA: hda - Refactor pm notification in hda_codec.c' is only one of them.

We observed audio failure (dead communication) after S3 if runtime PM is enabled on Haswell with Kernel v3.9.
We hope to back port your previous fix and further check this issue.

Many thanks!
Mengdong
