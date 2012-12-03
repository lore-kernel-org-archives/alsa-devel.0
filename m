From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] USB MIDI fixes
Date: Mon,  3 Dec 2012 11:48:56 +0100
Message-ID: <1354531738-22046-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D6FF026162A
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 11:49:14 +0100 (CET)
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
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Banks <amoebae@gmail.com>, Olivier MATZ <zer0@droids-corp.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of patches to fix pending issues wrt USB MIDI in the
recent kernels.

The first patch is to close the disconnection race for autopm and other
codes in sound/usb/midi.c.
The second patch is a fix for missing autopm handling for USB MIDI input,
which has been discussed shortly ago.

It's based on the latest 3.7-rc, but should be applicable to the latest
stable-queue for 3.6 and older, too.  The previous autopm fix in stable
tree isn't released yet, so you can't apply it to the released 3.6.y.
You'll need pick up the patch from stable-queue tree.


Takashi
