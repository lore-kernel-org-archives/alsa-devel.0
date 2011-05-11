From: Santosh Sivaraj <santoshs@fossix.org>
Subject: a xrun() query
Date: Wed, 11 May 2011 17:40:39 +0530
Message-ID: <20110511121039.GA19108@santoshs.mistral.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8502F103839
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 14:10:48 +0200 (CEST)
Received: by pzk26 with SMTP id 26so246393pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 05:10:44 -0700 (PDT)
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

Hi,

I am getting glitches while playing audio with aplay. With little
debugging I figured out that the state changes from RUNNING to XRUN at
which time the trigger gets called. I also figured out that XRUN state
is set in the function:

static int snd_pcm_update_hw_ptr_post(struct snd_pcm_substream *substream,
				      struct snd_pcm_runtime *runtime)
{
        <snip>
	} else {
		if (avail >= runtime->stop_threshold) {
			xrun(substream);
			return -EPIPE;
		}
	}
        </snip>
}

I am not able to find out why the condition (avail >
runtime->stop_threshold) becomes true. Can the experts here tell
during what use cases/scenarios this happens?

Thanks,
Santosh

-- 
http://fossix.org, http://dot.slashb.in

Luck is a matter of preparation meeting the opportunity.
					-- Anon
