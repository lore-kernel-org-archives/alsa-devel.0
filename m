From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/1] ALSA: hda - bug fix for
	invalid	connection list of Haswell HDMI codec pin
Date: Fri, 14 Dec 2012 08:04:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8294796@SHSMSX101.ccr.corp.intel.com>
References: <1355511450-2031-1-git-send-email-mengdong.lin@intel.com>
 <s5hk3slqfda.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82946F1@SHSMSX101.ccr.corp.intel.com>
 <s5hehitqdii.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A929026170D
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 09:04:13 +0100 (CET)
In-Reply-To: <s5hehitqdii.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, December 14, 2012 3:50 PM


> > But, do you mean we can change this to the pre-probe stage, so that
> > snd_hda_get_raw_connections() need not be called during the parsing the
> codec? I'll do a test.
> 
> Yes.  It may work currently but it might be broken if the parser code is
> changed, for example.  I see no reason why the fixup must be applied after
> parsing the tree.
>

Hi Takashi,

You're right. Overriding the connection list can work after being merged into 
the pre-probe stage and so only one fix-up is enough.

I'll update the patch. Many thanks for your advice!

- Mengdong
