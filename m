From: "Johannes Lorenz" <johannes89@mailueberfall.de>
Subject: parallel, real time safe waiting?
Date: Mon, 13 Apr 2015 19:56:02 +0200
Message-ID: <trinity-43de15d6-c64e-46fe-80ab-acaeb4930fc6-1428947762351@3capp-gmx-bs04>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C622926518B
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 19:56:02 +0200 (CEST)
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

Hello,

I'd like to write a sequencer that can handle many synthesizers. Thus, I want them to run these synths parallel. Still, I'd like to keep my code real time safe, i.e. no malloc(), usleep(), ofstream, pthread mutexes etc. However, I wondered how to let all my threads sleep for x useconds if there's nothing to do for x useconds.

My idea was:

  1.) Let each thread open a handle using snd_seq_open()
  2.) Call snd_pcm_wait() in each thread

Are these functions

  a) real time safe?
  b) race-condition free, assuming I'll use pairwise different handles each thread

Many thanks for any help.

Kind regards,
Johannes
