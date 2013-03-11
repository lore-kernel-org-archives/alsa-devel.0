From: Anders Alex <alibobar@gmail.com>
Subject: Re: twl4030 and Puredata/jack
Date: Mon, 11 Mar 2013 02:42:06 +0100
Message-ID: <CAAuz6apRE90QU5Hm-+jeEB4nxcZHUNp4_Hhfcgb_p7854FiwBw@mail.gmail.com>
References: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
 <513B99C0.8020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 050CF26520E
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 02:42:07 +0100 (CET)
Received: by mail-qc0-f174.google.com with SMTP id z24so1290869qcq.19
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 18:42:07 -0700 (PDT)
In-Reply-To: <513B99C0.8020805@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 9, 2013 at 9:21 PM, Gabriel M. Beddingfield
<gabrbedd@gmail.com>wrote:

> Strange.  In kernel 3.2, omap-mcbsp-dai.1 (McBSP1) is used for the codec.
>  But in the mainline it's omap-mcbsp-dai.2.
>
> So the question is... how is the board wired?  And does your kernel match
> the board?

1) no idea 2) it should, yes.


> Looking at the source, it looks like hw:0,0 has no capture port.  Try
> adding the -P parameter to jackd.  Playback only.
>
Hmm, when I do that I get:

[419034.693756] Alignment trap: not handling instruction edc46a06 at
[<4022ce2c>]
[419034.693878] Unhandled fault: alignment exception (0x801) at 0x4019e1e6

In dmesg.
Apparently this is/was a known issue on jack2 and has been fixed there.
No idea about jack1 (which I'm currently running). Will try to compile
latest jack2 and report back on this.


Also, post the output of:
>
>    $ cat /proc/asound/devices
>

$ cat /proc/asound/devices
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : time


>
> -gabriel
>
>
