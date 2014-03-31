From: Tobias Schlemmer <Tobias.Schlemmer@tu-dresden.de>
Subject: Re: cloning snd_seq_t (or creating one from client id)
Date: Mon, 31 Mar 2014 16:40:20 +0200
Message-ID: <53397E54.2060309@tu-dresden.de>
References: <53390BC4.5090900@gmx.net> <53395FA7.5050704@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060401000604090408060405"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.zih.tu-dresden.de (mailout1.zih.tu-dresden.de
 [141.30.67.72]) by alsa0.perex.cz (Postfix) with ESMTP id 0751B264FE3
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 16:40:23 +0200 (CEST)
In-Reply-To: <53395FA7.5050704@ladisch.de>
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

This is a multi-part message in MIME format.
--------------060401000604090408060405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 31.03.2014 14:29, schrieb Clemens Ladisch:
> Tobias Schlemmer wrote:
>> I'm surprised that the upcoming version of RtMidi uses one ALSA client=

>> per MIDI port.
>>
>> I found out that sequencer handles (snd_seq_t) are not thread safe.
> A sequencer client use a common buffer for the events of all ports.
Yes. Thus, I suggested to split the set of ports of a client into
disjoint subsets. Then each sequencer would handle only one of these
subsets, which should reduce the interference with other ports' code.
>> Could you provide some way to implement multithreaded ALSA clients?
> Multiple threads would have to synchronize the buffer accesses in some
> way.
That is not true. Programmers tend to program lock free, as locking
creates always a bottleneck. Other problems can occur if have different
load and different priority to the program. The current aproach that is
taken by kmid and RtMidi is to use different sequencers. The ALSA docu
suggests to use different sequencers in the latter way. Unfortunately
this does not comply with the idea of clients and ports as they are
presented to end users. So I suggested to hide this implementation
detail from the end user and present him all ports from all sequencers
of a program instance under one common client id. The port ids used in
the sequencers should be the same as the ones that are presented to the
end user in order to prevent unexpected behaviour.

How exactly merging and distributing of events from/to multiple
ports is handled (even when some thread does not react) is a policy that
cannot be imposed by the ALSA library.

The current policy is forcing the client to serialise events of
different connections that don't interfere. The ALSA imposes a policy
that is obviously is not necessary from a technical point of view as
every program instance can use different sequencer clients already with
the current implementation at the cost of worsening the usability. My
suggestion is to losen this restriction.

Regards,

Tobias

P.S.: We are talking about the library API right?

--------------060401000604090408060405
Content-Type: application/pgp-keys;
 name="0x73A2F90C.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x73A2F90C.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Diese Datei kann mit GnuPG gelesen werden.
Comment: This file is to be uses with GnuPG.

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
=3DLo8/
-----END PGP PUBLIC KEY BLOCK-----

--------------060401000604090408060405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060401000604090408060405--
