From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Unregister a card from userspace?
Date: Wed, 4 Nov 2015 12:24:42 +0100
Message-ID: <5639EAFA.9060008@ladisch.de>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1A159260431
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 12:24:45 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> My use case is that I have a card driver I'm working on as a module, and
> while insmodding it works fine, I can't rmmod it because once
> snd_soc_register_card() has been called, it has a usage count of 2 and
> thus cannot be rmmod:ed.

soc_probe_component() adds a reference to each component's driver's
module.  Maybe putting each component into its own module would help.

Anyway, you should be able to unbind the driver:
<https://lwn.net/Articles/143397/>


Regards,
Clemens
