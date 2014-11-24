From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 26/29] ALSA: oxfw: Add support AMDTP
	in-stream
Date: Mon, 24 Nov 2014 14:54:17 +0100
Message-ID: <54733889.8050303@ladisch.de>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>	<1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>	<54691544.2020501@ladisch.de>
 <546DC356.8010207@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B193E264F33
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 14:54:19 +0100 (CET)
In-Reply-To: <546DC356.8010207@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Nov 17 2014 06:21, Clemens Ladisch wrote:
>> And why are the substreams counters atomic?
>> Can't they just be normal variables accessed from inside the mutex?
>
> Just for my convinience. I didn't want to write many
> mutex_lock()/mutex_unlock() because wrong coding of them causes-dead
> lock

Just use a kernel compiled with CONFIG_PROVE_LOCKING.

> An attached patch achieves your idea over my patchset. Handling
> reference counter is easy to understand (because it's arithmetric
> operation) but I don't like much mutex_lock()/mutex_unlock().
>
> Can I request you to explain about the advantages of your idea?

It makes the driver work correctly.

There's nothing wrong with atomic_t itself, but in this case, none of
the accesses would be valid outside of the lock, so it is not necessary
for them to be atomic.

In theory, it would be possible to use atomic_t to synchronize multiple
streams, but this requires that
1. two CPUs that start a stream at the same time do not both think they
   are the first, so you *must* use something like atomic_inc_and_test(),
   and
2. when one CPU is still starting a stream, code on all other CPUs must
   be able to work correctly, without synchronization.  This is not
   possible if the code requires to know that the DMA actually has
   started; consider the following code:

   void start_some_substream(...)
   {
       if (atomic_inc_and_test(substreams)) {
           mutex_lock();
           // lots of stuff to start DMA ...
           mutex_unlock();
       } else {
           // wait for the DMA to be started
       }
       ...
   }

   How could the 'else' branch ensure that the DMA engine is started?
   Just taking the mutex is not enough, because it could happen before
   the mutex_lock() of the first stream.  This is not possible without
   moving the inc_and_test into the locked region.


Regards,
Clemens
