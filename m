From: Sinan Akman <sinan@writeme.com>
Subject: Re: Wandboard Quad - SPDIF issue, no sound
Date: Tue, 24 Jun 2014 19:49:34 -0400
Message-ID: <53AA0E8E.6030508@writeme.com>
References: <53A86CC5.2060204@dewberryfields.co.uk>
 <53A90D98.3050000@writeme.com> <53A991F4.9070905@dewberryfields.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from walmailout08.yourhostingaccount.com
 (walmailout08.yourhostingaccount.com [65.254.253.237])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E87F2608CF
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 01:49:46 +0200 (CEST)
Received: from walmailscan15.yourhostingaccount.com ([10.1.15.15]
 helo=walmailscan15.yourhostingaccount.com)
 by walmailout08.yourhostingaccount.com with esmtp (Exim)
 id 1WzaTB-0001Cr-Ky
 for alsa-devel@alsa-project.org; Tue, 24 Jun 2014 19:49:45 -0400
In-Reply-To: <53A991F4.9070905@dewberryfields.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Howard <mike@dewberryfields.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


   Hi Mike

> I have tried a second receiver and the results are the same, as in, the
> wandboard fails, the cubietruck works. I fear that this a design issue
> and I'm wasting your time.

   There is one another thing. When you run aplay for testing I suggest
you define the format and the rate explicitly and don't use plugin
as part of your device. It is possible that your default format that
your aplay on wandbord picks is not compatible with what your receiver
can handle.

   Regards

   Sinan Akman
