From: Mr ARM <mrarmdev@gmail.com>
Subject: Handling a device which zeroes the memory on IO start
Date: Tue, 30 Jul 2019 23:00:01 +0200
Message-ID: <CAKSqxP9m2ObY94DumdYcnn2bOT0sj1=Lsow5i8sN1oZPQwZJqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD6DAF80214
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 23:00:13 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id r12so28950369edo.5
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 14:00:13 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

My issue involves a specific device quirk. The device generally uses a
mmap'ed memory regions, however sending a StartIO command (from a trigger)
causes a full buffer erase (which is completed once I get an initial
UpdateTimestamp several milliseconds later), and it seems that alsa fills
the DMA buffer before calling the start trigger. I'm unsure how to
workaround this issue. I have seen the SNDRV_PCM_INFO_DOUBLE flag, however
it didn't help me in my issue as from what I understand it's merely an
information that the driver is using double buffering.

One option is to make the start trigger method copy the buffer, send the
StartIO command, then do a blocking-wait for initial timestamp and restore
the buffer. I don't think I can get rid of the blocking wait here if I use
this temporary-buffer-copy approach as I think that in the time before I
get the timestamp update, a client could try to update the shared memory
resulting in that data being lost after I restore the original contents
later.
Another idea I had is to do the same, but in the open callback, however
that seems totally wrong.

Any ideas are appreciated. I tried grepping for drivers using the
SNDRV_PCM_INFO_DOUBLE flag, however I couldn't find any code workarounding
similar issues.

Thank you,
Paul Pawlowski

PS: I wrote an email yesterday to this mailing list from another email
address, however I have received several SPF failures, so I switched to
gmail. Regarding the previous mail, I have figured out the looping audio
was caused by the lack of a snd_pcm_period_elapsed call. I have missed it
because my device has no proper interrupt handler, and only sends a
confusingly named UpdateTimestamp message once the buffer has been fully
processed. I'm however still unsure as for what I should return from the
_pointer function as the device does not provide a frame pointer.
