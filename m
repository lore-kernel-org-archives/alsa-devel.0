From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 14/39] firewire-lib: Add handling output
 connection by CMP
Date: Mon, 10 Mar 2014 21:30:10 +0900
Message-ID: <531DB052.6090008@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-15-git-send-email-o-takashi@sakamocchi.jp>
 <531CDCB5.7040908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 262682656E0
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:30:13 +0100 (CET)
In-Reply-To: <531CDCB5.7040908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 06:27), Clemens Ladisch wrote:
> This function is always used with a constant master parameter, and the
> two branches don't really share much code.  Two functions would be simpler:
>
> static u64 mpr_address(struct cmp_connection *c)
> {
> 	if (c->direction == CMP_INPUT)
> 		return CSR_REGISTER_BASE + CSR_IMPR;
> 	else
> 		return CSR_REGISTER_BASE + CSR_OMPR;
> }
>
> static u64 pcr_address(struct cmp_connection *c)
> {
> 	if (c->direction == CMP_INPUT)
> 		return CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index);
> 	else
> 		return CSR_REGISTER_BASE + CSR_OPCR(c->pcr_index);
> }

This is a good idea.


Takashi Sakamoto
o-takashi@sakamocchi.jp
