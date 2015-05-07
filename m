From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa triggering methods
Date: Thu, 07 May 2015 15:38:19 +0200
Message-ID: <554B6ACB.30505@ladisch.de>
References: <CAAVaN8wvo4Aq_ij1K_Nt2Jnc6qO8XDsd5X2hvsFKSAzQhbts2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B0155265857
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 15:38:22 +0200 (CEST)
In-Reply-To: <CAAVaN8wvo4Aq_ij1K_Nt2Jnc6qO8XDsd5X2hvsFKSAzQhbts2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Ng <andreas2025@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andy Ng wrote:
> I am working on a ALSA card driver that handles a DSP instance. The
> problem I have is that the triggering mechanism in ALSA to start a PCM
> has the interrupts disabled, and my dsp framework is actually
> acknowledging the start trigger with an event after 50 microseconds
> time that I can't handle because the IRQs are disabled.

Why must you handle the ACK interrupt from inside the trigger?


Regards,
Clemens
