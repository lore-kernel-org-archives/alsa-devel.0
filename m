From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cloning snd_seq_t (or creating one from client id)
Date: Mon, 31 Mar 2014 14:29:27 +0200
Message-ID: <53395FA7.5050704@ladisch.de>
References: <53390BC4.5090900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6776E264F06
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 14:29:28 +0200 (CEST)
In-Reply-To: <53390BC4.5090900@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tobias Schlemmer <keinstein_junior@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobias Schlemmer wrote:
> I'm surprised that the upcoming version of RtMidi uses one ALSA client
> per MIDI port.
>
> I found out that sequencer handles (snd_seq_t) are not thread safe.

A sequencer client use a common buffer for the events of all ports.

> Could you provide some way to implement multithreaded ALSA clients?

Multiple threads would have to synchronize the buffer accesses in some
way.  How exactly merging and distributing of events from/to multiple
ports is handled (even when some thread does not react) is a policy that
cannot be imposed by the ALSA library.


Regards,
Clemens
