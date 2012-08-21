From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 13:44:15 +0200
Message-ID: <5033748F.40509@ladisch.de>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337005.7090404@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C7D03265352
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 13:44:15 +0200 (CEST)
In-Reply-To: <50337005.7090404@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> 5) I'm not sure I'm getting the _VAR and _PAIRED types, even though
> I read the documentation. Is this for the query only?

AFAIU this types appear only in the TLV, which is read only.  The TLV
documents what channel configurations are possible, while the current
configuration is read/changed through the control value, which is
a plain array of integers, one for each channel, without headers.

So _VAR implies that the control's value can be set to any permutation
of the channels in the TLV.


Regards,
Clemens
