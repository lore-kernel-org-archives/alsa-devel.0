From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Alsa triggering methods
Date: Wed, 6 May 2015 16:35:00 +0530
Message-ID: <20150506110500.GT3521@localhost>
References: <CAAVaN8wvo4Aq_ij1K_Nt2Jnc6qO8XDsd5X2hvsFKSAzQhbts2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB8E260704
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 13:04:11 +0200 (CEST)
Content-Disposition: inline
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
To: Andy Ng <andreas2025@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 04:24:09PM +0100, Andy Ng wrote:
> Hi,
> 
> I am working on a ALSA card driver that handles a DSP instance. The
> problem I have is that the triggering mechanism in ALSA to start a PCM
> has the interrupts disabled, and my dsp framework is actually
> acknowledging the start trigger with an event after 50 microseconds
> time that I can't handle because the IRQs are disabled.
> 
> Is there any way when the trigger mechanism goes down to the card to
> be able to handle any acknowledgements what will happen within a sort
> period of time.
> 
> I have seen bespoke triggering method but not sure if everyone is using it.
> 
> Any ideas would be helpful.
trigger can be nonatomic too, you can set nonatomic = true for your pcms

-- 
~Vinod
