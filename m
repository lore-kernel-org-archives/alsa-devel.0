From: errordeveloper@gmail.com
Subject: Re: Kirkwood SoC - AVB support questions ..?
Date: Sat, 10 Jul 2010 12:01:05 +0100
Message-ID: <20100710110105.GM7638@00110101.home>
References: <20100709200117.GC7635@00110101.home>
	<4C382C37.7090904@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C0AFD245B8
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 13:01:10 +0200 (CEST)
Received: by wyf19 with SMTP id 19so2263940wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2010 04:01:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C382C37.7090904@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok, so it's really no wonder about these,
those proprietary are hendeled transparently by an ASIC or an FPGA.

so this won't be the case with AVB,
i suppose at low sampling (48k or 44k1) it will work over a regular
network, provided the host is doing only AVB streaming and there is
no other trafic on the network.
I'm not intery sure how stream reservation would work, but may be
you can fake it in software somehow.

there is PTP driver patch here:
http://kerneltrap.org/mailarchive/linux-netdev/2010/4/29/6276033

it seems to be ptpv1 ..hm
this ptpd list thread is about patents:
http://lists.infradead.org/pipermail/ptpd/2010-January/000023.html

could these patents be such a problem?
will AVB support have to be distributed trough patches because of this?


well ..i haven't used Netjack or anything, so cannot tell.

On Sat, Jul 10, 2010 at 08:15:51PM +1200, Eliot Blennerhassett wrote:
> On 10/07/10 08:01, errordeveloper@gmail.com wrote:
> 
> > How are the CobraNet and EtherSound drivers designed, has anyone used
> > those cards ?? (one was from DigiGram and another from Audio Science IIRC)
> 
> AudioScience ASI6416 and AS6316 cards use cobranet processor from
> Cirrus, and appear to the host as a standard soundcard.
> 
> Similarly, ASI6585 uses hardware implementation of Axia livewire protocol.
> 
> So, none of the network audio protocol is handled by the host PC.
> 
> 
> -- 
> Eliot Blennerhassett
> AudioScience Inc.
