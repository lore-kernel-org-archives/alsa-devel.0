From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: cs42l52 alsa driver broken beep volume control
Date: Thu, 20 Jun 2013 09:15:18 -0500
Message-ID: <alpine.DEB.2.02.1306200914370.11823@heelrod.ad.cirrus.com>
References: <51C2BE92.5020901@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C7CB26529D
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 16:16:12 +0200 (CEST)
In-Reply-To: <51C2BE92.5020901@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org

n Thu, 20 Jun 2013, Lars-Peter Clausen wrote:

> Hi,
>
> I stumbled upon this while making some changes to the SOC_SINGLE_VALUE
> macro. For the Beep Volume control the cs42l52 driver sets the invert field
> to 7, which doesn't make much sense and is causing a build warning with my
> changes. I assume the intention was to actually use SOC_SINGLE_SX_TLV
> instead of SOC_SINGLE_TLV. But I'm not sure if setting min to 0x1f and max
> 0x7 is right either. Also according to the datasheet the tlv dB info seems
> to be wrong. The Beep Volume uses 2dB steps while the info uses 0.5dB steps.
>
> - Lars
>
>
Yep, the min and max are backwards...

I'll fix it

Brian
