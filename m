From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Test device for automated testing
Date: Wed, 16 Sep 2015 14:59:04 +0200
Message-ID: <55F96798.70106@ladisch.de>
References: <55F9617A.6040301@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id AC73D2614D6
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 14:59:11 +0200 (CEST)
In-Reply-To: <55F9617A.6040301@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
> we're currently writing a lot of ALSA user space applications. In order
> to test this code with our unit testing and other test environments we'd
> like to know if there's a dummy PCM device which provides the
> fundamental operations like reading/writing and setting the common
> hardware parameters.

That would be the snd-dummy module.

If you cannot load kernel drivers, you could try the virtual "null"
device, but that one does not have realistic timing.


Regards,
Clemens
