From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Player Thread is not woken after period elapsed
Date: Mon, 5 Sep 2011 10:52:53 -0700
Message-ID: <20110905105253.2787b91f@infradead.org>
References: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id E91D824372
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 19:49:33 +0200 (CEST)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Sep 2011 23:08:53 +0530
"Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com> wrote:

> Hi,
> 
> When I tried to root cause a glitch in the audio playback, I found a
> weird behavior. 
> 
> User thread which invokes the writei function which in turn  invokes
> a kernel function which waits for the free buffer to write the audio
> data.  This kernel function adds this thread to a wake(sleep) queue
> and calls a schedule_timeout (msecs_to_jiffies(10000)).

actually it doesn't... you must be on some really really old kernel or
something.


> 
> Will you provide some hint on how to go about identifying the root
> cause?

https://lkml.org/lkml/2011/9/5/201



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
