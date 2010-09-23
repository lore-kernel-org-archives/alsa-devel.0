From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: ASoC how to modify audio IC register values
Date: Thu, 23 Sep 2010 08:44:27 +0300
Message-ID: <20100923084427.03bdde3b.jhnikula@gmail.com>
References: <8CD27E1B735BE77-18DC-119C@webmail-d060.sysops.aol.com>
	<i7dqg6$v7j$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DACAD103803
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 07:43:57 +0200 (CEST)
Received: by ewy21 with SMTP id 21so371856ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 22:43:57 -0700 (PDT)
In-Reply-To: <i7dqg6$v7j$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philip Balister <philip@balister.org>
Cc: alsa-devel@alsa-project.org, alfayez@aol.com
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Sep 2010 16:55:33 -0400
Philip Balister <philip@balister.org> wrote:

> On 09/21/2010 04:21 PM, Almohanad Fayez wrote:
> > I'm running the 2.6.28 Linux kernel.  can anyone share some advice ???
> 
> I'm interested in the solution also. I'm familiar with the work Al is 
> doing and have never found a satisfactory solution. The basic problem is 
> we are receiving samples of digitized RF containing an FM radio signal. 
> Due to contraints on the sample rates of the RF hardware we end up with 
> audio at odd rates (such as 32K). If you let libsamplerate fix the rate, 
> we us more processor than we have available.
> 
> If anyone knows if the Beagle hardware can support different sample 
> rates and how to add support to the ALSA driver, I'd love to hear 
> suggestions.
> 
TWL4030 codec on Beagle supports more rates but they come in 2.6.29. I
think it should work on 2.6.28 too if you apply the commit
bbba944410310181de14a5c60a7c161ff2447dd9.

But better option is to upgrade the kernel. These days the Beagle is
well supported in Vanilla too.


-- 
Jarkko
