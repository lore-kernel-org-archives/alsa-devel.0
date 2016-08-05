From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Stale data interleaved in capture driver
Date: Fri, 5 Aug 2016 10:18:44 +0200
Message-ID: <ee683e13-52e0-5b21-c468-563b36cb4641@ladisch.de>
References: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
 <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
 <CALAeOVOZZgh5SThku3SF_7CPrrm_SbLEbR83mkSMefCy5GdrKA@mail.gmail.com>
 <9db62b13-f027-0986-5458-8ff9495a0cd0@ladisch.de>
 <CALAeOVPavUscy-wRmY=QTqfCOM8AD5ZqLh+D23bsTa9js9UnaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 181B0265885
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 10:18:53 +0200 (CEST)
In-Reply-To: <CALAeOVPavUscy-wRmY=QTqfCOM8AD5ZqLh+D23bsTa9js9UnaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> I've rewritten the DMA to fire an IRQ only at the write-completion of
> (buffer_bytes/2) and (buffer_bytes)

Is the DMA actually restricted to two interrupts per buffer?  If not,
your driver should support arbitrary period sizes.


Regards,
Clemens
