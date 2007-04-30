From: Tim Burrell <tim.burrell@gmail.com>
Subject: Possible bug in snd_mixer_selem_set_playback_switch_all
Date: Mon, 30 Apr 2007 14:19:30 -0300
Message-ID: <46362522.3050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.eastlink.ca (smtpout.eastlink.ca [24.222.0.30])
	by alsa0.perex.cz (Postfix) with ESMTP id C54472463E
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2007 19:19:33 +0200 (CEST)
Received: from ip04.eastlink.ca ([24.222.10.20])
	by mta01.eastlink.ca (Sun Java System Messaging Server 6.2-4.03 (built
	Sep 22 2005)) with ESMTP id <0JHB00J4EMSJCYH0@mta01.eastlink.ca> for
	alsa-devel@alsa-project.org; Mon, 30 Apr 2007 14:19:32 -0300 (ADT)
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

Hi there,

I've encountered a situation where if I very quickly, and repeatedly
make calls to snd_mixer_selem_set_playback_switch_all I get some strange
undefined behavior.

The situation is I'm looping over all mixer elements (on all sound
cards) to do a system wide mute / unmute.  If I make numerous calls to
this function it ends up that some mixers only toggle switches on
specific channels (right or left), and sometimes the volume on certain
(random) channels gets set to some also random (usually 0, but can be
anywhere between 0 and max) level.

I've been able to remedy the situation by inserting a 10ms delay in
between calls to snd_mixer_selem_set_playback_switch_all.  Clearly
though this is undesirable.

I don't have more than one sound card to test on so I can't be sure if
it's a problem with all drivers or just mine (hda-intel).

I can certainly provide more information if requested, just let me know
what I can do.  Or if I'm doing something wrong I'd love to be made
aware of something I can do to fix this behavior.

Thanks,

Tim.
