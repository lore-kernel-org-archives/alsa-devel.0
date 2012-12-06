From: itxEpsilon <carlos@isometrica.net>
Subject: Re: How to mix two PCM channels with ALSA
Date: Thu, 6 Dec 2012 16:18:06 +0000 (UTC)
Message-ID: <loom.20121206T171348-66@post.gmane.org>
References: <loom.20121206T132219-620@post.gmane.org>
 <50C0AA5F.1040503@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DB602615D2
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 17:18:22 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Tge9g-0002Zx-4D
 for alsa-devel@alsa-project.org; Thu, 06 Dec 2012 17:18:32 +0100
Received: from 128.Red-2-136-253.dynamicIP.rima-tde.net ([2.136.253.128])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2012 17:18:32 +0100
Received: from carlos by 128.Red-2-136-253.dynamicIP.rima-tde.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2012 17:18:32 +0100
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

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> itxEpsilon wrote:
> > I'm trying to write a simple application
> > for mixing two PCM sound channels in
> > C++. Could anyone provide me a
> > quick example about how to implement
> > this operation?
> 
>   outputSample[i] = inputChannel1[i] + inputChannel2[i];
> 
> What does this have to do with ALSA?
> 
> Regards,
> Clemens
> 

Hi,
That's no my question, I'd like to know how is performed with the ALSA API.

i.e. 

playSound(buffer1);
playSound(buffer2);

is it implicitly mixed when playing two buffers by hardware?

Thanks.
Carlos.
