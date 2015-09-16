From: Uli Franke <uli.franke@weiss.ch>
Subject: Re: Test device for automated testing
Date: Wed, 16 Sep 2015 15:15:06 +0200
Message-ID: <55F96B5A.6000900@weiss.ch>
References: <55F9617A.6040301@weiss.ch> <55F96798.70106@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [62.146.13.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1359A2614F6
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 15:15:08 +0200 (CEST)
In-Reply-To: <55F96798.70106@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 16.09.2015 14:59, Clemens Ladisch wrote:
> Uli Franke wrote:
>> we're currently writing a lot of ALSA user space applications. In order
>> to test this code with our unit testing and other test environments we'd
>> like to know if there's a dummy PCM device which provides the
>> fundamental operations like reading/writing and setting the common
>> hardware parameters.
> 
> That would be the snd-dummy module.

Great - that's what we're looking for. I'll check it out.

> If you cannot load kernel drivers, you could try the virtual "null"
> device, but that one does not have realistic timing.

I tried the "null" but this fails when setting hw parameters with an
assertion.


Regards
Uli
