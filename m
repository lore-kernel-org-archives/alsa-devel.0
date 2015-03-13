From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Fri, 13 Mar 2015 15:36:55 +0100
Message-ID: <20150313153655.610514ca7ecac1ddb7d934d9@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150312144503.5e1d556e408a0b166e20058d@ao2.it>
 <5501A30E.2000408@linux.intel.com>
 <20150313063345.GC32000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id DF624264FE3
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 15:37:01 +0100 (CET)
In-Reply-To: <20150313063345.GC32000@intel.com>
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
Cc: alsa-devel@alsa-project.org, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Mar 2015 12:03:45 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Thu, Mar 12, 2015 at 04:30:38PM +0200, Jarkko Nikula wrote:
[...]
> > Vinod, Ramesh: Do you know would it be possible to run that Android
> > ELF firmware that is installed in the Teclast with the newer stack
> > in sound/soc/intel/sst?
> Sorry havent followed the thread, but we should be able to use the upstream
> firware.
> The ELF binary and the upstream ones are similar, we decided sometime back
> to not use ELF for future dev so we didnt upstream that part.
> 

Jakko said that the firmware distributed at linux-firmware.git
hardcodes the SSP to SSP2, while on some boards the codec may be
connected to SSP0, which could be my case.

That was the whole point of trying to reuse the firmware that was
working in my Android installation.

Any hint about how to extract the firmware from the ELF and convert it
to an SST firmware image usable with the upstream drivers? I could dig
into the sources and figure out the structures myself but maybe you have
some more accessible information.

Vinod, if you feel like catching up, the thread is also here:
http://thread.gmane.org/gmane.linux.alsa.devel/134554

I ask a lot of questions, I know.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
