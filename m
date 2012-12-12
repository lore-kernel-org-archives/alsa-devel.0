From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bug in aplay?
Date: Wed, 12 Dec 2012 12:59:01 +0100
Message-ID: <50C87185.6030008@ladisch.de>
References: <CABXa2sHAWX-q=tpMdLqJSXbu-kNeuuhhPY5UQ41qKQ+SisD=Rg@mail.gmail.com>
 <s5h38zbh557.wl%tiwai@suse.de>
 <CABXa2sEdsWcT8Prq59mTO6szeSvO9-AD6Me=gPF3-wpAGgHB9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 10530261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 12:59:03 +0100 (CET)
In-Reply-To: <CABXa2sEdsWcT8Prq59mTO6szeSvO9-AD6Me=gPF3-wpAGgHB9A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> pi@raspberrypi ~ $ hexdump -C 48000-S24_3BE.wav |head
> 00000000  52 49 46 58 01 c3 20 48  57 41 56 45 66 6d 74 20  |RIFX.. HWAVEfmt |

aplay does not support big-endian .wav files.


Regards,
Clemens
