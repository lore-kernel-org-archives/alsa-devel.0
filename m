From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Rationale behind snd_pcm_htimestamp()
Date: Mon, 16 Feb 2009 03:35:09 +0100
Message-ID: <20090216023509.GA16494@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C6B93103815
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 03:35:10 +0100 (CET)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

I am interested to query the current delay and the current avail
atomically together with the timestamp when they were current.

Apparantly there is now a function that can get the former two
atomically (snd_pcm_avail_delay()) and another one that gets the latter
two atomically (snd_pcm_htimestamp()). _avail_delay() seems to sync
the hw index data, _htimestamp() apparently not. Hence I had assume
that first calling _avail_delay() and then _htimestamp() one after the
other without any further access would return the same avail
value. Turns out, my test results on an USB card show that this
assumption is not true.

An alternative way seemed to be to go via the snd_pcm_status
structure. However querying that seems not to sync the hw index
data. Hmm... so let's call snd_pcm_hwsync() right before querying the
struct -- as it turns out however, that function is now deprecated. So
which function should I call? The doxygen comments of _hwsync() kind
of suggest in a way to call snd_pcm_avail_update(), whose doxygen
comments however declare that it does in fact *not* sync the hw state
either, but suggest to use snd_pcm_avail() for that.

Ok, so I am now tempted to first call snd_pcm_avail() and then
snd_pcm_status() and have all three values atomically. But unfortunately
that's not the case. Again the avail value of the two calls differs sometimes.

How can I query the three values atomically? Can i do that at all?

Also, snd_pcm_hw_params_is_monotonic() always returns 0 on all my
devices. I am calling that function after having set both HW and SW
params. Kernel is 2.6.27, alsa-libs is 1.0.19. The kernel itself does
monotonic/hrtimers just fine.

Hmm, last week I started this discussion about "snd_pcm_busy_for()"
(aka granularity API). Who can I bribe to get an API like this?
Although snd_pcm_busy_for() would suit me much better than just a call
to query the granularity, I'd be happy with either...

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
