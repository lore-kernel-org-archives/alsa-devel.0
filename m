From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 09:13:53 -0700
Message-ID: <5166E141.2030401@gmail.com>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
 <5166D295.2070400@list.ru> <5166DB38.1010706@gmail.com>
 <5166DEBC.8070702@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 545302610B1
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 18:13:56 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id x11so932103pdj.10
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 09:13:55 -0700 (PDT)
In-Reply-To: <5166DEBC.8070702@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Steve Chen <schen@mvista.com>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 09:03 AM, Stas Sergeev wrote:
> What is the reason of adding platform data for a dummy driver?

Because some audio "codecs" have a static configuration or are 
configured by magic.  (E.g. a modem in a phone.)  I think that being 
able to declare a board-specific set of "dummy DAI's" in the board file 
is helpful.

-gabriel
