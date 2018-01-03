From: Freaky <freaky2000@gmail.com>
Subject: Headphone issues iMac 14.1 (A1418)
Date: Wed, 3 Jan 2018 11:39:57 +0100
Message-ID: <CAEw6Zyteav09VGHRfD5QwsfuWv5a43r0tFBNbfcHXoNrxVz7ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C0EBF266CFE
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 11:40:01 +0100 (CET)
Received: by mail-qt0-f179.google.com with SMTP id 33so1596547qtv.1
 for <alsa-devel@alsa-project.org>; Wed, 03 Jan 2018 02:40:00 -0800 (PST)
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

Hi there,

we're having issues enabling the headphone out on an iMac 14.1 (A1418).

The parameters snd-hda-intel.model=imac27 or snd-hda-intel.model=imac27_122
do not resolve the problem.

Plug detection seems to be working fine, upon plugging the headphone,
speaker-out will mute and headphone out will unmute. Unplugging it does the
reverse. There's no audio on the headphone out however.

We ran the hda analyzer python script and when enabling 'out-dir', 'enable'
and 'data' on the GPIO's marked as [2] the audio starts working.

If we unplug/plug the headphone then the audio is dead again. Need to
uncheck and check them and it will work again.

Ran alsa-info.sh, whilst the GPIO's marked as [2] were enabled:

http://www.alsa-project.org/db/?f=86db8b16d0118edd1feab9626c68eed4735b943e

Would be much obliged if can help with a solution for this. Preferably with
a kernel parameter as we run a stateless image that's used on a huge
variety of systems.

Tried different kernel versions by the way, problem still exists in 4.14.8
at least.

Thanks in advance and best wishes for the new year to you all!

Kind regards,

Ferry
