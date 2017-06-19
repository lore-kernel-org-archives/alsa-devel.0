From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib: Dmix slowptr latency behaviour
Date: Mon, 19 Jun 2017 10:07:43 +0200
Message-ID: <1bf33588-6d75-bffd-3db4-7623e1fe3a50@ladisch.de>
References: <CAPdSWWRCeXakghaDxSXms9ui5uV3RNHGeiiPpvO1B8gfDBGrew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8431C266DCC
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 10:07:44 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id B647B5580F3E
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 10:07:43 +0200 (CEST)
In-Reply-To: <CAPdSWWRCeXakghaDxSXms9ui5uV3RNHGeiiPpvO1B8gfDBGrew@mail.gmail.com>
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

Matin Momin wrote:
>> arecord -D"dsp" -r48000  -c2 -fs32_le | aplay -D"dmix1"

To reduce the latency, reduce arecord's period size and/or aplay's
buffer size.

> Now, in the same configuration if I disable slowptr in dmix1, the
> delay comes down to 160 msecs, which corresponds exactly to buffer
> time (85 msecs).

Did you do multuple measurements?


Regards,
Clemens
