From: Mark Farrugia <mark.farrugia@fiberdyne.com.au>
Subject: Possibility of routing at the kernel level
Date: Fri, 24 Aug 2018 16:27:01 +1000
Message-ID: <CAPWhKMn_4SukFcaLEMGTa8R70c3q0VjufvnFzFeMg=Gpn+T9AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0B426766C
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2018 08:27:11 +0200 (CEST)
Received: by mail-it0-f49.google.com with SMTP id e14-v6so781882itf.1
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 23:27:11 -0700 (PDT)
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
Cc: James O'Shannessy <James.OShannessy@fiberdyne.com.au>, Tharindu De Silva <Tharindu.DeSilva@fiberdyne.com.au>
List-Id: alsa-devel@alsa-project.org

Hi all,

I am currently using the ALSA loopback driver to create a "virtual"
sound card to abstract underlying real sound cards.  I capture from
the loopback in user-space, and then subsequently playback to a real
sound card.

The issue with this is that there is a significant latency introduced
(~100ms) due to the number of transitions of the stream from user to
kernel space. I am seeking a way to avoid this.

My question is this: is there any way of routing PCM substreams at the
kernel level, so that we can avoid the need to pipe audio back up to
user-space with the loopback capturer?  If there is no current
solution that would achieve this, I would proposition to design and
implement a system that uses a top-level ALSA driver, which then
routes dynamically to one or many subscribed lower-level "audio path"
drivers.  The system would also have the option to loopback upon
itself.

Does anyone see any reason that I couldn't (or shouldn't) attempt such
a solution? All feedback is welcome.

Regards,
Mark
