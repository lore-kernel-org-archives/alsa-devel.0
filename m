From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 18:28:00 +0100
Message-ID: <510AA9A0.4060009@ladisch.de>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C018526163F
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 18:28:54 +0100 (CET)
In-Reply-To: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brent Weatherall <brentweatherall@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Brent Weatherall wrote:
> At a high level, when configuring the built in audio device (3.5 mm jack),
> the device accepts ANY rate requested (via snd_pcm_set_rate_near).  it
> accepts unsupported rates without alteration.  If the rate is actually not
> supported, then 'snd_pcm_hw_params' fails with error '-22'.

This sounds as if the driver published incorrect constraints.

Do you have a pointer to the driver's source code?


Regards,
Clemens
