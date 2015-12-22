From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: rawmidi virtual and long sysexes
Date: Tue, 22 Dec 2015 06:51:47 +0100
Message-ID: <821A542B-D0E2-4AD5-A3EF-18A937735B3B@ladisch.de>
References: <20151219233143.GK28165@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id EFAFB2651DB
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 06:51:52 +0100 (CET)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id D54402043F
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 00:51:51 -0500 (EST)
In-Reply-To: <20151219233143.GK28165@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nemesis@icequake.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ryan C. Underwood wrote:
>Basically, the rawmidi virtual plugin enforces a 256-byte limit on
>events, and emits multiple events if e.g. a >256 byte sysex is
>encountered.

All sequencer clients have such a limit.

>This does not seem to be documented behavior for
>snd_seq_event_input(), nor is the fixed limit described anywhere.

Yes, the documentation is lacking.

>Would it be better if the maximum event size could be configured
>through params?  That would avoid needing this clumsy workaround by
>sequencer clients.

Handling split messages cannot be avoided; the API is not
capable of sending arbitrarily large messages.


Regards,
Clemens
