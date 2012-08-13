From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 3/3] ALSA: hda - Disable DigEn bit before
 stream-id change
Date: Mon, 13 Aug 2012 07:37:12 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48900FF44217@SHSMSX102.ccr.corp.intel.com>
References: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
 <1344838271-3528-3-git-send-email-xingchao.wang@intel.com>
 <s5htxw7w8lh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id EF01626528C
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 09:07:30 +0200 (CEST)
In-Reply-To: <s5htxw7w8lh.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, August 13, 2012 3:32 PM
> To: Wang, Xingchao
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH 3/3] ALSA: hda - Disable DigEn bit before stream-id change
> 
> At Mon, 13 Aug 2012 14:11:11 +0800,
> Wang Xingchao wrote:
> >
> > Follow the protection way in nvhdmi_8ch_7x_pcm_prepare().
> 
> Could you clarify why this is needed?

> I don't mean an objection, but just need to know if there is any other devices
> that need this fix.  If there really is, better to put a bit more details in
> changelog or comment.

No, it's not really a fix for the issue.
I just found the change when to investigate HDMI HBR issue and it does NOT help fix the issue.
However I thought it's a fix to some other bug(seen from comments), so I think it's also needed as
a common solution. Please correct me if I am wrong.

Thanks
--xingchao
