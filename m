From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Roland/Edirol M-16DX
Date: Fri, 23 Oct 2015 13:01:02 +0200
Message-ID: <562A136E.3030108@ladisch.de>
References: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0B1292615C0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 13:01:06 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
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
> I seem to recall reading posts not to long ago that refer to using an
> implicit feedback path; my question is, was this in fact implemented,

Yes, for USB Audio 2.0 devices.

> meaning that a device like the M-16DX should function as expected also for
> playback?

There is some bug in the code that should detect such Roland devices.


Regards,
Clemens
