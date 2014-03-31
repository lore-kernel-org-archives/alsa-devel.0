From: Tobias Schlemmer <keinstein_junior@gmx.net>
Subject: cloning snd_seq_t (or creating one from client id)
Date: Mon, 31 Mar 2014 08:31:32 +0200
Message-ID: <53390BC4.5090900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9440626512B
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 08:31:34 +0200 (CEST)
Received: from [192.168.2.204] ([92.227.125.117]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M4kfR-1XFkap0sjV-00yz56 for
 <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 08:31:34 +0200
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

Hi,

Recently, I came upon the following problem with the ALSA sequencer
interface:
I'm surprised that the upcoming version of RtMidi uses one ALSA client
per MIDI port.
As an end user I'd expect to see only one ALSA client per program
instance (e.g. using aconnect -i - o -l).
Asking for the reason of that change I got the answer that it has
something to do with broken multithread support.

Digging deeper into this problem I found out that sequencer handles
(snd_seq_t) are not thread safe.
So my question is:
Could you provide some way to implement multithreaded ALSA clients?

My idea is to provide some function
int snd_seq_clone(snd_seq_t * old, snd_seq_t ** new) /* clone a sequencer */
and/or
int snd_seq_create_from_client(int clientid, snd_seq_t ** new) /* create
a sequencer from a given client id */
and/or
int snd_seq_split_port(snd_seq_t * old, snd_seq_t ** new, int port) /*
create a sequencer that steels a port from old */

For the semantics I think cloned sequencers should act as if they don't
know each other.
Each one has its own set of ports. While the generation of port numbers
still uses the same counter. I don't expect creating a port to be that
time critical that it can't use locks.

If it helps to ease the implementation one could use a master sequencer
with some slaves. If the master sequencer is deleted the slaves are
automatically freed and must not be used anymore.

And if a subsequencer tries to access a port of another subsequncer,
ALSA could just return with an error.

Regards,

Tobias

P.S.: please, CC to me in answers.
