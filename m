From: Davin McCall <davmac@davmac.org>
Subject: mmap_commit() and hardware buffering
Date: Tue, 1 Nov 2005 16:56:51 +1100
Message-ID: <20051101165651.2a5f125b.davmac@davmac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have an intel 8x0 card and Alsa 1.0.9.

Despite snd_pcm_hw_params_is_batch() and is_double() both returning false, the hardware seems to be double buffering the mmap buffer. That is, if I snd_pcm_mmap_commit() the whole buffer, and then immediately modify the buffer, the modification doesn't take effect - the sound hardware just outputs the original contents of the buffer.

Can anyone confirm whether these cards actually do double buffering? Or is there something else going on here?

I am trying to get wine's alsa driver behaving better. It was committing the whole buffer, then progressively committing the buffer again as it became available. The result on my system is that sounds play twice.

The best improvement I've got so far is to commit only a couple of periods worth of data at the beginning, and then commit a single period each time the callback is called (i.e. commit another period as a period is drained). This means the software mixer is able to stay ahead of the commit pointer. However it also means that the potential for buffer underrun is greatly increased, because there are only ever two periods committed.

My thinking is that for double-buffered cards, the driver could demand that the lock/unlock buffer calls be used (i.e. the direct sound layer has to lock part of the buffer before updating it, and unlock it when done), in which case the driver has much better info about how much it can commit (a portion of the buffer can be committed when it is unlocked).

For non-double buffered cards it would be better to use the previous strategy, however, as this allows just-in-time mixing. Unfortunately though is_batch() and is_double() seem to give incorrect information - so I'm not sure how to decide which strategy should be used.

Any ideas?

Also I'd be interested if there is any way to do just-in-time mixing (rendering) for double-buffered hardware?


Thanks,

Davin


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
