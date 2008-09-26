From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: maintaining fixed latency between output and input?
Date: Fri, 26 Sep 2008 08:33:19 +0200
Message-ID: <48DC822F.2030706@ladisch.de>
References: <20080926010525.GP1107@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 04E85103808
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 08:33:15 +0200 (CEST)
In-Reply-To: <20080926010525.GP1107@arwen.poofy.goof.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aaron J. Grier" <agrier@poofygoof.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Aaron J. Grier wrote:
> what's the most straight-forward way to maintain fixed latency between
> output and input without sitting in loop and continuously checking
> snd_pcm_avail_update() for the output and input descriptors?
>
> I was originally going to use callbacks, but I've recently read that is
> not a good idea.  poll() seems to be the reccomended method.

Yes.

> I'm visualizing something like this:
>
> for(;;)
> {
> 	poll()
>
> 	if (output_is_ready)
> 	{
> 		/* write output buffer */
> 		/* do output-side housekeeping */
> 	}
>
> 	if (input_is_ready)
> 	{
> 		/* read input buffer */
> 		/* do input-side housekeeping */
> 	}
>
> 	/* communicate with other threads */
> }

This is exactly how a full-duplex application should be structured.

To communicate with other threads, you can use a pipe so that you have
a file descriptor that can be used with the poll().

> combining the output and input snd_pcm_t into a single descriptor list
> for poll() seems straight-forward, but can I pass this superset list to
> snd_pcm_poll_descriptors_revents() without it getting confused?

No, snd_pcm_poll_descriptors_revents() looks at the file descriptors of
a single device and returns the ready status of that device.


HTH
Clemens
