From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v3 00/11] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Sun, 25 Aug 2013 23:10:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308252049300.14562@heraclitus>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BBADA2619E0
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 23:10:18 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id na10so887628bkb.0
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 14:10:18 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sun, 25 Aug 2013, Eldad Zack wrote:

> Hi,
> 
> This patch series attempts to fix a long standing problem with the concurrent
> usage of playback and capture on implicit feedback devices.

My crude regression tester caught a problem causing the streams to 
fail with this order (though it doesn't trip any WARNs or oops):

++ Test stream permutation 0000013f
  * [1/14] capture => pcm_open
  * [2/14] capture => pcm_hw_params
  * [3/14] capture => pcm_prepare
  * [4/14] capture => pcm_start
  * [5/14] capture => waitsleep
  * [6/14] capture => pcm_stop
  ++ Frames [capture]: 39360
  * [7/14] playback => pcm_open
  * [8/14] playback => pcm_hw_params
  * [9/14] capture => pcm_close
  * [10/14] playback => pcm_prepare
  * [11/14] playback => pcm_start
  * [12/14] playback => waitsleep
  * [13/14] playback => pcm_stop
  ++ Frames [playback]: 101760
  * [14/14] playback => pcm_close
++ Test stream permutation 0000015f
  * [1/14] capture => pcm_open
  * [2/14] capture => pcm_hw_params
  * [3/14] capture => pcm_prepare
  * [4/14] capture => pcm_start
  * [5/14] capture => waitsleep
  * [6/14] playback => pcm_open
  * [7/14] capture => pcm_stop
  ++ Frames [capture]: 0
!! Test stream permutation 0000015f failed !!

For reference, I ran the tool with my hda-intel card (all 3432 
combinations) and there were no errors.
So it's still doesn't cover all cases.

Cheers,
Eldad
