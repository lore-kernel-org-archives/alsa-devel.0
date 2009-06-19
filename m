From: Adam Williamson <awilliam@redhat.com>
Subject: Re: IDT quirks...where?
Date: Fri, 19 Jun 2009 15:25:21 -0700
Message-ID: <1245450321.313.514.camel@adam.local.net>
References: <1245448160.313.510.camel@adam.local.net>
	<604760770906191505jf8f1134ie406b8bed0ad4e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A883246C6
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 00:25:24 +0200 (CEST)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5JMPNFO007881
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 18:25:23 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5JMPMhG024441
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 18:25:22 -0400
Received: from [10.16.10.32] (vpn-10-32.bos.redhat.com [10.16.10.32])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5JMPLZU019784
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 18:25:22 -0400
In-Reply-To: <604760770906191505jf8f1134ie406b8bed0ad4e3b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-06-19 at 18:05 -0400, Daniel Chen wrote:
> On Fri, Jun 19, 2009 at 5:49 PM, Adam Williamson<awilliam@redhat.com> wrote:
> > patch_*.c files seems to cover IDT codecs. What's the story with these?
> > Where do their quirks go? Does current ALSA have one already? (I did try
> 
> Use sound/pci/hda/patch_sigmatel.c::stac92hd71bxx_cfg_tbl[].

Thanks for that. We chatted on IRC: follow up for the list, this is
already covered in current ALSA (by a wildcard, which is why I missed
it), but F11 is still using ALSA driver bits from kernel 2.6.29 (so
1.0.18a vintage). Practically speaking it's probably not worth trying to
backport the later IDT/Sigmatel fixes, I'll just leave it and it'll get
fixed when F11 goes to kernel 2.6.30.

Thanks very much for the information, Daniel.

-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Fedora Talk: adamwill AT fedoraproject DOT org
http://www.happyassassin.net
