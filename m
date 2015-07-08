From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 8 Jul 2015 18:21:32 +0200
Message-ID: <20150708182132.db38656fb4ccc2e38e41aba0@ao2.it>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
 <559D3411.6060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id B4455264F09
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 18:21:39 +0200 (CEST)
In-Reply-To: <559D3411.6060306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tyler Yeomans <tyeo098@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 Jul 2015 10:30:41 -0400
Tyler Yeomans <tyeo098@gmail.com> wrote:

[...]
> Additionally, you were correct about the sorting of interrupts, as my 
> dissembled DSDT table shows:
> (from Device(LPEA) section)
>        Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x0000001D,
>                  }
[...]
> 
> For now I can research into overriding the DSDT so the interrupts are in 
> order.

You can follow Documentation/acpi/dsdt-override.txt, but maybe patching
the driver is faster for a quick test; just remember to revert the
driver change if you reorder the interrupts in the DSDT later on :)

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
