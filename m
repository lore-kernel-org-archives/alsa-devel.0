From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Some questions about userspace control elements
Date: Sun, 01 Feb 2015 20:41:06 +0900
Message-ID: <54CE10D2.7090903@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F2BB26058E
 for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2015 12:41:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear all,

I have some questions about ALSA control interface.

Currently I'm working for writing control applications in userspace. The
application adds some control elements to a certain control device, then
execute interprocess communication via the device by ALSA control interface.

To help this work, I'm preparing for alsa-gir, with partly implementation of
ALSA Control/Timer/Sequencer interface.
(Currently I have no plan to support the other interfaces, such as PCM.)

https://github.com/takaswie/alsa-gir

Then I have six questions.

1.The 'numid' is unique number for each element or not.
2.The 'numid' is always zero in SND_CTL_EVENT_MASK_ADD event.
3.The way to change permissions of each control element.
4.Added elements are not removed when closing fd.
5.Processes can delete elements which the other processes added.
6.The operation to replace element generates separate events.

In detail:
1.The 'numid' is unique number for each element or not?
I want to use it to indicate each element, if possible. But there're
more members in snd_ctl_elem_id structure.

2.The 'numid' can be notified in SND_CTL_EVENT_MASK_ADD event?
As long as I test, it's always zero when userspace applications add any
elements. Is it an expected behaviour? Or a bug?

3.The way to change permissions of each control element.
Is it possible after adding the elements? If possible, how to notify it
in the other processes?

4.Any elements added by a process are not removed at closing snd_ctl_t.
They're remained after closing the process' snd_ctl_t. Is it an expected
behaviour? Or a bug?

5.Processes can delete elements which the other processes added.
Is it an expected behaviour? Or a bug?

6.The operation to replace elements generates separate events.
ADD/REMOVE events occurs sequencially. Userspace application cannot
distinguish replacement from adding/removing, therefore cannot process
appropriate action. Is it an expected behaviour? Or a bug?


Regards

Takashi Sakamoto
