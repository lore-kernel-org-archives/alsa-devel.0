From: Tim Cussins <timcussins@eml.cc>
Subject: proposal: snd_pcm_start_at()
Date: Thu, 02 Oct 2014 15:34:20 +0100
Message-ID: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 427DC260475
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 16:34:21 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by gateway2.nyi.internal (Postfix) with ESMTP id 677AD206DD
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 10:34:20 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm Tim: I work at Linn Products Ltd - we make Network Music Players,
amongst other things.

As you might imagine, synchronised-start is important when multiple
devices on the network are rendering the same audio. We'd be interested
in contributing a small expansion of the alsa-lib API to support
synchronised start.

Assuming we can synchronise the audio clocks (I'm aware this is not
trivial - It's not the topic of this post), we'd propose something like:

    int snd_pcm_start_at(snd_pcm_t* pcm, snd_htimestamp_t* tstamp);

and playback would begin as close to tstamp as possible. If tstamp is in
the past, it would should return an error.

Recent work by Takashi Iwai enables client code to set the clock type of
timestamps using snd_pcm_sw_params_set_tstamp_type(). This context could
quite naturally extend to tstamp argument of snd_pcm_start_at().

Before I get stuck into working up the details under the hood, it'd be
good to get some feedback/objections regarding this approach.

Thanks in advance!
Tim
