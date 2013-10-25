From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH RESEND v2 2/4] ASoC: cs42l52: increase
 MAX_REGISTER for regmap_register_patch
Date: Fri, 25 Oct 2013 15:26:07 -0500
Message-ID: <alpine.DEB.2.10.1310251523460.11514@heelrod.ad.cirrus.com>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
 <20131025153736.GA26122@sirena.org.uk>
 <alpine.DEB.2.10.1310251244140.11514@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A9E22616E9
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 22:23:52 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1310251244140.11514@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

>> Hrm.  It probably shouldn't be doing that, unless there's some great
>> reason I've not thought of - this is for random undocumented registers
>> which we ought to be able to exclude from the the register map that
>> Linux knows about.  What's the root cause?

Let me spend some time after the weekend and see what the deal is.
It's not a super critical patch and can wait till we figure out what's up.

-Brian
