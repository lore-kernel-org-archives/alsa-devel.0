From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs42l52: convert platform data
 config to regmap_update_bits
Date: Thu, 24 Oct 2013 09:22:51 -0500
Message-ID: <alpine.DEB.2.10.1310240922270.17987@heelrod.ad.cirrus.com>
References: <1382624409-10419-1-git-send-email-brian.austin@cirrus.com>
 <1382624409-10419-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C192608E9
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 16:20:35 +0200 (CEST)
In-Reply-To: <1382624409-10419-2-git-send-email-brian.austin@cirrus.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


On Thu, 24 Oct 2013, Brian Austin wrote:

> Moving Platform Data config to bus probe and convert to
> regmap_update_bits. This will work nicer when converted to device tree
> instead of having it split into multiple probes
>
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>

I forgot to run checkpatch...
I will resend
