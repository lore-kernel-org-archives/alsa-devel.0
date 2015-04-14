From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: parallel, real time safe waiting?
Date: Tue, 14 Apr 2015 21:49:50 +0200
Message-ID: <552D6F5E.1080204@ladisch.de>
References: <trinity-2fe2e26e-7e13-48a5-90f7-959800b5d1ed-1429036761827@3capp-gmx-bs63>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BE85F260561
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 21:50:17 +0200 (CEST)
In-Reply-To: <trinity-2fe2e26e-7e13-48a5-90f7-959800b5d1ed-1429036761827@3capp-gmx-bs63>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johannes Lorenz <johannes89@mailueberfall.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Johannes Lorenz wrote:
>>>   b) race-condition free, assuming I'll use pairwise different handles
>>>   each thread
>>
>> Yes.
>
> You're really 100 percent sure that this is guaranteed to work?

Of course.  Not only does this page say so:
http://www.alsa-project.org/main/index.php/SMP_Design
but I also guaranteee to give your money back.  ;-)


Regards,
Clemens
