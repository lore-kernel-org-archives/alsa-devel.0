From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: I/O errors,
 snd_pcm_hw_params_get_ functions don't deliver values and system
 freezes on drop/drain/close
Date: Fri, 23 Oct 2015 15:57:39 +0200
Message-ID: <562A3CD3.1000504@metafoo.de>
References: <1445521660731.90972@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42193261734
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 15:57:43 +0200 (CEST)
In-Reply-To: <1445521660731.90972@rwth-aachen.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bommes, Michael" <Michael.Bommes@rwth-aachen.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/22/2015 03:47 PM, Bommes, Michael wrote:
[...]
> 
> System freeze looks like driver issue, or might this only be a wrong usage of the driver?

Trying to configure a ALSA sound card with wrong parameters should not
result in a system freeze or any other kind of system failure. The driver
should reject those values and report an error to the application and that's it.

So it looks like there is an issue with the driver that you are using. I'd
recommend to contact the driver vendor and ask them for assistance.

- Lars
