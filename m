From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What causes a STOP in the trigger?
Date: Thu, 13 Sep 2018 09:29:51 +0200
Message-ID: <03d6f461-2354-7a2a-8d70-340321213c97@ladisch.de>
References: <CALAeOVNOMzpvRtRoCrJP7fz3CKJppybFzkLMM=N4fQo4wYTgQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id C74572676EB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 09:29:53 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id A01D355836C0
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 09:29:52 +0200 (CEST)
In-Reply-To: <CALAeOVNOMzpvRtRoCrJP7fz3CKJppybFzkLMM=N4fQo4wYTgQw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob wrote:
> I'm seeing a weird issue where ALSA doesn't ever hit the pointer function,
> and we go straight from START to STOP. Debugging the DMA, we get IRQs, I
> call the period_elapsed.

The pointer is called from that.

Sounds like a bug somewhere.


Regards,
Clemens
