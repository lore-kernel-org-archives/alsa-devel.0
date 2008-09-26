From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: maintaining fixed latency between output and input?
Date: Thu, 25 Sep 2008 18:05:26 -0700
Message-ID: <20080926010525.GP1107@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BAAE243F4
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 03:05:34 +0200 (CEST)
Received: from arwen.poofy.goof.com (muzgash.poofy.goof.com [10.0.0.26])
	by smtp.poofygoof.com (Postfix) with ESMTP id BB1EE29DC
	for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2008 18:05:30 -0700 (PDT)
Content-Disposition: inline
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

what's the most straight-forward way to maintain fixed latency between
output and input without sitting in loop and continuously checking
snd_pcm_avail_update() for the output and input descriptors?

I was originally going to use callbacks, but I've recently read that is
not a good idea.  poll() seems to be the reccomended method.

I could use separate threads for output and input, but then I have to
perform synchronization between them, marshal external requests between
the two threads, and make a lot more work for myself.

I'm visualizing something like this:

for(;;)
{
	poll()

	if (output_is_ready)
	{
		/* write output buffer */
		/* do output-side housekeeping */
	}

	if (input_is_ready)
	{
		/* read input buffer */
		/* do input-side housekeeping */
	}

	/* communicate with other threads */
}

combining the output and input snd_pcm_t into a single descriptor list
for poll() seems straight-forward, but can I pass this superset list to
snd_pcm_poll_descriptors_revents() without it getting confused?

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com
