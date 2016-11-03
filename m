From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Difference between boundary and buffer_size
Date: Thu, 3 Nov 2016 21:01:59 +0100
Message-ID: <d4897ef6-0b6b-826a-ecea-a4f9a821737a@ladisch.de>
References: <581AFF28.5060500@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0AC02266B59
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 21:02:33 +0100 (CET)
In-Reply-To: <581AFF28.5060500@IEE.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <Alan.Young@IEE.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Young wrote:
> there are always initialized to the same value.

No.  Have a look into /proc/asound/cardX/pcm0p/sub0/hw_params.

> In what circumstance might they be different?

Always.

The boundary value is an integer multiple of the buffer size.  It's used
to allow computing the difference of two pointer values even if that
difference is larger than the buffers size.


Regards,
Clemens
