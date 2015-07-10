From: Luka Karinja <lk@bazdara.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 10 Jul 2015 17:24:07 +0200
Message-ID: <559FE397.4080207@bazdara.com>
References: <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org> <559A90CE.2030105@gmail.com>
 <20150707031950.GD11002@localhost> <559BDB7F.9010105@gmail.com>
 <20150707170821.GL11002@localhost> <559C3F4A.5030307@gmail.com>
 <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
 <559D88C1.3010504@bazdara.com> <20150710040032.GW836@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.bazdara.com (server.bazdara.com [84.255.206.229])
 by alsa0.perex.cz (Postfix) with ESMTP id E06072665C2
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 17:24:08 +0200 (CEST)
In-Reply-To: <20150710040032.GW836@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas George <george@nsup.org>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, Antonio Ospite <ao2@ao2.it>, Tyler Yeomans <tyeo098@gmail.com>
List-Id: alsa-devel@alsa-project.org


> irq index in deafult shoudl work for t100, you should see interrupts
even with .acpi_ipc_irq_index = 5 the output of the interupts while 
playing is:
pinkflozd@bazdara-t100taf:~$ cat /proc/interrupts | grep sst
    6:          0          0          0          0   IO-APIC 
28-fasteoi   intel_sst_driver

In both situations there is just huge heat coming from the speaker and a 
few clicks not related to playing sound

The T100TAF (Atom Z3535G & rt5642) seems to be using different 
interrupts order than the T100TA (AtomZ3775 & rt5640)

                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001D,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x00000018,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x00000019,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001A,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001B,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001C,
                 }

I did try to sort them (based on Antonios suggestion) but got lots of 
errors when recompiling so i need to explore that a bit further

>
> That wont work, I have verfied with T100, it is SSP2 based, so SSP0 will nto
> work here. I am trying to get this tested on latest driver and provide a
> working config. Will update shortly
>
I did try the "old" driver for SSP0 that the guys with a T100TA are 
using but on the T100TAF doesn't work, so maybe the TAF is using 
something other than SSP2?

Please keep me CC'ed for any followups on this mater

Thanks
