From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM substream
Date: Fri, 10 Aug 2012 08:45:32 +0200
Message-ID: <5024AE0C.7040302@ladisch.de>
References: <CABnBtVCEP0z_2_1NaPyvMpq1C=6CM9fPcM=6znpjGMZaT8STNQ@mail.gmail.com>
 <CABnBtVDJQ_0nTLwfFrbMN1w16z7upNY3=ui1Oi1mZJmaHztiGQ@mail.gmail.com>
 <5023B1C3.40001@ladisch.de>
 <CABnBtVAg0QQVPxakC6+=uKtPocm3qYBMbC-01uHAsu-5Xyo36g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 33B8626530B
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 08:15:49 +0200 (CEST)
In-Reply-To: <CABnBtVAg0QQVPxakC6+=uKtPocm3qYBMbC-01uHAsu-5Xyo36g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arun kumar <arun.esd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

arun kumar wrote:
> So, if any application tries to open more than one substream will it
> get the error?

If there is no free substream available, the application will get an
error.

(If some mixing sound server like PulseAudio is used, this does not
matter.)


Regards,
Clemens
