From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Thu, 03 Jun 2010 16:48:29 +0200
Message-ID: <4C07C0BD.8000009@ladisch.de>
References: <1275514176.8032.42.camel@satellite> <4C074E63.90508@ladisch.de>
	<1275573648.1415.6.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id F4039103A98
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 16:48:33 +0200 (CEST)
In-Reply-To: <1275573648.1415.6.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Lindgren wrote:
> On Thu, 2010-06-03 at 08:40 +0200, Clemens Ladisch wrote:
> > Alsa-lib is not thread safe.
> 
> From http://alsa-project.org/main/index.php/Main_Page:
> 
>         ALSA has the following significant features:
>         ...
>         SMP and thread-safe design.
> 
> So, that's a big lie?

That applies to the kernel code.

Most functions in alsa-lib must not be called at the same time on the
same device handle.  (Don't ask me where this is documented.)

> > ... poll()
> 
> Would it work to simply call snd_pcm_wait?

Yes.  (I usually suggest poll because the code that writes audio data
often wants to be informed of some other event.  If your writing loop
doesn't need to be interrupted, snd_pcm_wait works just fine.)


Regards,
Clemens
