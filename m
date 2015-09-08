From: Mina Almasry <almasrymina@google.com>
Subject: Getting notification of sound card load
Date: Tue, 8 Sep 2015 10:09:39 -0700
Message-ID: <CAHS8izNFuofTe1Ud7Oa=L0RTtdT-KqnTdoO81ffMjDwH9RiyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id D22252650F2
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 19:09:40 +0200 (CEST)
Received: by iofb144 with SMTP id b144so126468706iof.1
 for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2015 10:09:39 -0700 (PDT)
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

Hi,

I'd like to get a notification when a new sound card becomes available in
my system. What's the best way to do that?

For example, when I 'cat /proc/asound/cards' I usually see one sound card
available. But if I plug in USB speakers to my system and then run 'cat
/proc/asound/cards', I see that the USB sound card is ready for the device
I just plugged in.

What's the best way via C API to get a notification that a new card has
been loaded? Is there a better way that looking for changes on
/proc/asound/cards?

Thanks,
Mina
