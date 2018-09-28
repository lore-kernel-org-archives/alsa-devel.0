From: Rob Duncan <rduncan@tesla.com>
Subject: Thread spinning in kernel
	snd_pcm_link()/snd_pcm_unlink()
Date: Fri, 28 Sep 2018 09:23:24 -0700
Message-ID: <dw77emy3bl4mmb.fsf@tesla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0019bd01.pphosted.com (mx0b-0019bd01.pphosted.com
 [148.163.155.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 01007267738
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 18:23:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I'm trying to address a bug where we end up with a thread spinning and
consuming an entire cpu.  The issue seems to be this code in
sound/core/pcm_native.c:

    /* Writer in rwsem may block readers even during its waiting in queue,
     * and this may lead to a deadlock when the code path takes read sem
     * twice (e.g. one in snd_pcm_action_nonatomic() and another in
     * snd_pcm_stream_lock()).  As a (suboptimal) workaround, let writer to
     * spin until it gets the lock.
     */
    static inline void down_write_nonblock(struct rw_semaphore *lock)
    {
            while (!down_write_trylock(lock))
                    cond_resched();
    }

The original commit for this is 67ec1072b053c15564e6090ab30127895dc77a89

What we're suspecting is that a normal thread (SCHED_OTHER) has a reader
lock and a real-time thread using SCHED_RR or SCHED_FIFO is trying to
take the writer lock.  If both threads are pinned to the same CPU for
some reason then the reader thread will never get scheduled (because the
real-time writer thread is still runnable), and we will never make
progress.

Does this sound right?  What can we do to fix this?

Thanks,

Rob.
