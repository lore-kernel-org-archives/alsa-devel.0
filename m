From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 15:45:35 +0200
Message-ID: <540F047F.7090607@ladisch.de>
References: <540C76E0.9050808@gmail.com>	<540CC53B.7080204@ladisch.de>	<540D5B46.3020904@gmail.com>	<540EBD9A.9000009@ladisch.de>
 <540EC08E.4000906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4E5A126512B
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 15:45:38 +0200 (CEST)
In-Reply-To: <540EC08E.4000906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> can the proposed heuristic (minimum period size for a given sample
> rate, number of channels and sample format) be useful as an upper-
> bound approximation of the pointer update granularity for cards that
> are "rewindable even further than the nearest period"?

No; USB precsion depends on the URB size, which is roughly proportional
to (but smaller than) the period size.


Regards,
Clemens
