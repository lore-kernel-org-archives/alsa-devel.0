From: Angus McInnes <angus@amcinnes.info>
Subject: Bug: plugging in a new sound card causes mixer state
 of other sound cards to be changed
Date: Sun, 1 Dec 2013 12:27:25 +0200
Message-ID: <CACdZ0c8-7eqhShFwQJfaMis-AtK5Sh-_nZuyhHY61wJ-CjzbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D7BB260844
 for <alsa-devel@alsa-project.org>; Sun,  1 Dec 2013 11:27:27 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id v10so16299550pde.0
 for <alsa-devel@alsa-project.org>; Sun, 01 Dec 2013 02:27:26 -0800 (PST)
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

When I plug in my USB sound card, the mixer settings of the internal
sound card are changed. I don't want this to happen.

I believe the problem is with this commit:

http://git.alsa-project.org/?p=alsa-utils.git;a=blobdiff;f=alsactl/90-alsa-restore.rules.in;h=3ce9a6540d551cdfe1d10a43e7f767c27c551fe7;hp=fe0e1ed0ae248d810f433a2af5c72e86e17dfaf0;hb=8b34bf25c02693899b03768b0eef628eb1d7bb6e;hpb=611249ae26f435429dbe1894e210704a723ee277

The card number $attr{number} comes from the card* device. Since
KERNELS=="card*" was changed to KERNELS!="card*", alsactl restore is
run with no card number attribute, so it restores the state of all
cards.

If I change the != back to ==, alsactl restore is run with a card
number and the problem seems to be resolved.

(By the way, your bug tracker at
https://bugtrack.alsa-project.org/alsa-bug seems to be down.)

Regards,
Angus McInnes
