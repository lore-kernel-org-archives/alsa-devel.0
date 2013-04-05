From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Fri, 05 Apr 2013 23:48:13 +0300
Message-ID: <515F388D.4060707@sonarnerd.net>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
 <515E8105.9070607@gmail.com>
 <7.0.0.16.2.20130405092937.144d10d0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B294262632
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 22:48:14 +0200 (CEST)
In-Reply-To: <7.0.0.16.2.20130405092937.144d10d0@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

On 04/05/2013 10:59 PM, Andreas Koch wrote:
> However, they are interpreting the ASIO spec for DSD differently.  They
> express buffer size in samples, which means that for DSD it is measured
> in bits.

That's how pretty much everybody, including Sony who co-authored the 
spec, has been interpreting it so far...

Otherwise all the latency calculations become inconsistent and need 
special exceptions for DSD. I agree the ASIO spec is not very clear, 
however it always talks about number of samples and then specifically 
mentions that DSD samples are _packed_ into bytes and thus all buffer 
sizes have to multiples of eight.

I have a hidden configuration flag to flip that either way as necessary, 
but default is that sizes are in _bits_.


	- Jussi
