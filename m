From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 03 Jul 2015 09:51:02 +0100
Message-ID: <1435913462.2478.14.camel@loki>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
 <558BA1D8.8040508@intel.com> <55931EE8.5000604@gmail.com>
 <20150702184035.GA1418140@phare.normalesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 051C8260484
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 10:51:06 +0200 (CEST)
In-Reply-To: <20150702184035.GA1418140@phare.normalesup.org>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jarkko Nikula <jarkko.nikula@intel.com>, Tyler Yeomans <tyeo098@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-07-02 at 20:40 +0200, Nicolas George wrote:
> Hi.
> 
> Tyler Yeomans:
> > I was able to recompile the distribution kernel after a long wait, and with
> > the changes that were made I was able to get some semblance of an audio
> > device registered.
> > 
> > I've attached the dmesg.
> > 
> > $ aplay -l
> > **** List of PLAYBACK Hardware Devices ****
> > card 0: bytrt5640 [byt-rt5640], device 0: Audio rt5640-aif1-0 []
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > 

Can you try the bytcr_rt5640 machine driver as the byt-rt5640 machine
driver will be getting deprecated (since it only works with a small
number of FWs). The bytcr_rt5640 driver works with a wider range of FW.

Thanks

Liam


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
