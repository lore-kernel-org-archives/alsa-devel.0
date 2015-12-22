From: Stas Sergeev <stsp@list.ru>
Subject: Re: rawmidi virtual and long sysexes
Date: Tue, 22 Dec 2015 23:23:16 +0300
Message-ID: <5679B134.1000903@list.ru>
References: <20151219233143.GK28165@localhost.localdomain>
 <821A542B-D0E2-4AD5-A3EF-18A937735B3B@ladisch.de>
 <20151222181147.GL28165@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp9.mail.ru (smtp9.mail.ru [94.100.181.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE10265A15
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 21:20:16 +0100 (CET)
In-Reply-To: <20151222181147.GL28165@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, nemesis@icequake.net
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2015 at 06:51:47AM +0100, Clemens Ladisch wrote:
>> Ryan C. Underwood wrote:
>>> Basically, the rawmidi virtual plugin enforces a 256-byte limit on
>>> events, and emits multiple events if e.g. a >256 byte sysex is
>>> encountered.
>> All sequencer clients have such a limit.
Clemens, could you please clarify what did you mean in this message:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/088852.html
Didn't you mean the limit is 4096?


> Handling split messages cannot be avoided; the API is not
> capable of sending arbitrarily large messages.
We are having this problem with munt, and for munt the
largest sysex it can parse, is AFAIK around 300 bytes.
It doesn't need the arbitrary large messages, because they
are illegal for it. It should better have them dropped entirely.
IMHO it would be nice to have the default buffer size large
anough to avoid the fragmentation for all practical cases,
leaving the fragmentation capability only for the pathological/
theoretical cases.
4096 is enough for this. 1024 is enough. 256 is obviously
not. So IMHO it would be nice to just enlarge the default
and save people from the troubles they actually really do
not need to take. I mean, even the 1-byte buffer will work,
but is it sane? pipes etc have >=4096 bytes AFAIK, so it
is obviously not a problem for kernel to allow just that.
So the question is very simple: why not?
