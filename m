From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Revert "ALSA: firewire-lib: fix inverted
 node IDs for amdtp_packet events"
Date: Mon, 24 Jun 2019 18:14:51 +0900
Message-ID: <20190624091450.GB7004@workstation>
References: <20190623012333.12056-1-o-takashi@sakamocchi.jp>
 <s5hwohbz7ax.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 073A4F89721
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 11:14:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwohbz7ax.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 24, 2019 at 11:00:54AM +0200, Takashi Iwai wrote:
> On Sun, 23 Jun 2019 03:23:33 +0200,
> Takashi Sakamoto wrote:
> > 
> > This reverts commit e703965a129cdd72ff74e248f8fbf0d617844527.
> > 
> > When creating this patch, I compared the value of src field to the
> > value of first byte of cip_header field (SID) in tracing event.
> > But in this test I used a device which has a quirk to transfer
> > isochronous packet with invalid SID.
> 
> Could you give your sign-off and fixes tags?

I'll resubmit with them...


Thanks

Takashi Sakamoto
