From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Discarding the first few frames inside the kernel
Date: Mon, 18 Jan 2016 12:21:33 -0600
Message-ID: <CACaQK7CtpKQK_j5q+F6ekK_j+w3SLQ=RQ0yR76+81ETvsg1Qdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C9B5B261A5A
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 19:21:33 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id n5so76941906wmn.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 10:21:33 -0800 (PST)
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

Hello All,

I am interfacing the ICS43432 MEMS microphone with McBSP interface. The
data sheet of the ICS43432 microphone shows that it takes about 4.5ms
(16kHz sampling rate) for startup. Because of this, I hear a transient
noise at the beginning of every stream. Is there in any way I can discard
the frames inside the kernel space itself before reading the samples using
snd_pcm_readi() call?

I was able to mute the first few frames after the readi() call, but would
want to know if I could do it before the readi() call itself inside the
kernel space.

Appreciate any help!

Thanks,
Ankhit
