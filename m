From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Bug#635362: Realtek ALC889: HDA Intel and kernel
 3.0 gives choppy sound
Date: Wed, 27 Jul 2011 00:52:00 +0200
Message-ID: <j0ngeg$bav$3@dough.gmane.org>
References: <4E2F2E47.8080902@herbesfolles.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 577F7103803
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 00:52:15 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QlqU2-0007i5-N8
	for alsa-devel@alsa-project.org; Wed, 27 Jul 2011 00:52:14 +0200
Received: from 178-83-206-236.dynamic.hispeed.ch ([178.83.206.236])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2011 00:52:14 +0200
Received: from belegdol by 178-83-206-236.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2011 00:52:14 +0200
In-Reply-To: <4E2F2E47.8080902@herbesfolles.org>
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

W dniu 26.07.2011 23:14, Colomban Wendling pisze:
> Hi,
> 
> Following a bug report started in Debian BTS, in bug 635362 [1], I was
> asked to post here after testing upstream kernels and reproducing the bug.
> 
> So, here's the problem: my HDA audio chip [2] started to output very
> choppy sound with Linux kernel 3.0, while it worked perfectly well in
> previous versions -- latest two I used being 2.6.38 and 2.6.39 from
> Debian. Please note that simply booting on 2.6.39 works as usual, so
> it's IMHO definitely a driver regression.
> 
> I tried Debian's 3.0 as well as mainline 3.0 and git5 snapshots, and all
> 3 were affected by the problem -- though the kernel log isn't exactly
> the same.
> 
> I attach three dmesg outputs, always took after trying to play a sound
> (and hearing it choppy, it happens every time):
> 
> dmesg-3.0.0-mainline: dmesg when running 3.0 mainline
> dmesg-3.0.0-git5: when running 3.0-git5 snapshot
> dmesg-3.0.0-git5-2: same as dmesg-3.0.0-git5 but configured without
> CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS (doesn't change anything)
> 
> If you want to see dmesg from the 2.6.39 kernel (where sound works well)
> or Debian's 3.0, see respectively [3] and [4].
> 
> 
> Thanks by advance, and if you need any further details or testing,
> please let me know.
> 
> Regards,
> Colomban
> 
> 
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=635362
> [2] Realtek ALC889 on an MSI H55M-E33, see lspci in Debian bug [1] for
> details
> [3]
> http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=15;filename=dmesg-2.6.39-2-amd64;att=1;bug=635362
> [4]
> http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=15;filename=dmesg-3.0.0-1-amd64;att=2;bug=635362
I am probably wrong, but did you try setting CONFIG_SND_HDA_BUFFER_SIZE
to a larger value?

Julian
