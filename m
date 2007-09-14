From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Fri, 14 Sep 2007 18:47:05 +0200
Message-ID: <20070914184705.9ba48d80.krzysztof.h1@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
	<1189781567.3648.1210664373@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 14632244FA
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 18:40:03 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so645648nfd
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 09:40:02 -0700 (PDT)
In-Reply-To: <1189781567.3648.1210664373@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 14 Sep 2007 16:52:47 +0200
"Clemens Ladisch" <cladisch@fastmail.net> wrote:

> Krzysztof Helt wrote:
> > This patch adds additional check for OPL3 device. I found that PNP
> > region returned by the card is 0x380 - 0x38f but the OPL3 device is
> > located at 0x388 (standard FM device address).
> 
> On cards with an OPL4, it would use the entire range, where that last
> eight bytes are the OPL3-compatible registers.
> 

Ok. I haven't touched the size of the range or the range itself. I just added
a fallback to check range +8 (which is 0x388) after failure to find the OPL3
at the 0x380.

> 
> My card doesn't have PnP, but I guess the OPL4 detection wouldn't work
> on 92x either for the same reason.
> 
> 

Should the OPL4 detection has the same fallback or just all Opti cards
should search the FM chip at the range + 8 address?

Regards,
Krzysztof
