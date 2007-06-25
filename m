From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Query regarding pointer callback
Date: Mon, 25 Jun 2007 09:07:12 +0200
Message-ID: <1182755232.11077.1196859947@webmail.messagingengine.com>
References: <61445c750706221538j414508e0hcf2b9eeff9fbd47b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E75E424363
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 09:07:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706221538j414508e0hcf2b9eeff9fbd47b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> In Writing an ALSA driver, it is said that
> pointer callback is called usually from the buffer-update routine in
> the pcm middle layer, which is invoked when snd_pcm_period_elapsed()
> is called in the interrupt routine. Then the pcm middle layer updates
> the position and calculates the available space, and wakes up the
> sleeping poll threads, etc
> 
> What are the other places from where pointer callback is called?

Many places.  There are some other situations when the ALSA framework
wants to know the current position (e.g., pausing, stopping), and the
application can ask for the current position at any time.

> If it is not called from any other routine then does it mean that
> interrupts are occuring?

When it's never called, it means that snd_pcm_period_elapsed() never
was called.


HTH
Clemens
