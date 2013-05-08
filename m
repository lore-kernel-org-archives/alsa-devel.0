From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: TLV question - ranges not in volume order
Date: Wed, 08 May 2013 14:09:31 +0200
Message-ID: <518A407B.3070802@ladisch.de>
References: <518A3545.8000809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C95722652B3
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 14:09:34 +0200 (CEST)
In-Reply-To: <518A3545.8000809@canonical.com>
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
Cc: rex.tsai@canonical.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> I recently came across a strange ASoC volume control. In this case,
> the values are not in volume order, i e, the control is declared
> something like below.
>
> However alsamixer seems not to handle this "reordering" correctly. My
> question is if this is something that should be fixed in alsamixer (or
> possibly alsa-lib?), or does one need to write some kind of mapping
> table in the kernel, just to make something come in volume order to
> userspace?

Items in a DB_RANGE container must be ordered by their values *and* by
their dB values.  This implies that larger values must correspond with
larger dB values, whis is also required for all other mixer controls.

If the register values are unordered, the driver must reorder them.

> static const unsigned int tlv[] = {
>         TLV_DB_RANGE_HEAD(8),

This should be rewritten as:

static const DECLARE_TLV_DB_RANGE(tlv,
	0, 0, TLV_DB_SCALE_ITEM(-100, 0, 1),
	...
);


Regards,
Clemens
