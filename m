From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Fri, 14 Sep 2007 16:52:47 +0200
Message-ID: <1189781567.3648.1210664373@webmail.messagingengine.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C9A74244EE
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 16:52:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Krzysztof Helt wrote:
> This patch adds additional check for OPL3 device. I found that PNP
> region returned by the card is 0x380 - 0x38f but the OPL3 device is
> located at 0x388 (standard FM device address).

On cards with an OPL4, it would use the entire range, where that last
eight bytes are the OPL3-compatible registers.

AFAIK the opti93x chips have an integrated OPL3 and cannot be used
with an OPL4.

> If someone can test if the opti92x PnP has the same problem I would be
> grateful.

My card doesn't have PnP, but I guess the OPL4 detection wouldn't work
on 92x either for the same reason.


Regards,
Clemens
