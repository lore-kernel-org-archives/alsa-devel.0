From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 1/1] ALSA: hda - use usleep_range in
 link reset and change timeout check
Date: Thu, 13 Dec 2012 09:32:06 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8293588@SHSMSX101.ccr.corp.intel.com>
References: <1355321775-2042-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 302D02616B2
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 10:32:12 +0100 (CET)
In-Reply-To: <1355321775-2042-1-git-send-email-mengdong.lin@intel.com>
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
Cc: "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Would you please have a look on this patch?

This is a update to a patch submitted by Xingchao before:
[alsa-devel] [PATCH] ALSA - Replace msleep() with usleep_range() to save module loading time

Many thanks!
Mengdong
