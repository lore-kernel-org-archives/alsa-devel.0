From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei VS snd_pcm_mmap_writei
Date: Fri, 19 Nov 2010 09:21:30 +0100
Message-ID: <4CE6338A.3090405@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE370@EXGMBX01.sasken.com>
	<alpine.LNX.2.00.1011190808080.21207@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 99E0E24390
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 09:19:53 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011190808080.21207@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 19 Nov 2010, Irfan Shaikh wrote:
> >         Please tell me
> >         a) Difference between working of snd_pcm_mmap_writei and snd_pcm_writei ?
> 
> The mmap functions does not require user space / kernel context switches.
> 
> >         b) Performance wise which is better ?
> > 
> >         When i use gettimeofday almost profile time comes almost same for both of them.
> 
> With current hw power, there are no major differences.

Yes, the context switches have no noticeable impact on latency or
throughput.

The only case where using the mmap functions makes sense is when the
program generates the samples on the fly and can write them directly
into the device's buffer.  If, however, the samples are already in some
other buffer and are to be copied into the device's buffer, then this is
_exactly_ the same situation as snd_pcm_writei.

If your algorithm requires that you always use snd_pcm_mmap_writei,
then you shouldn't have used mmap in the first place.


Regards,
Clemens
