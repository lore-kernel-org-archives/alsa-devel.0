From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: problems in getting rid of set_xfer_align
Date: Mon, 19 Oct 2009 23:39:30 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0910192155520.7934@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E68BA24593
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 22:42:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre Lorenzon <devel@pollock-nageoire.net>
List-Id: alsa-devel@alsa-project.org

Hello all,

here's one problem that I stumbled on with the deprecated 
snd_pcm_sw_params_set_xfer_align() function. I'm not sure if anything 
needs to be done to this, but at least FYI for other app developers that 
might hit the same issue.

In short, ecasound-2.7.0 was just released, and as one of the last 
commits, I dropped the call to snd_pcm_sw_params_set_xfer_align() as it 
has been deprecated since early 2008 in ALSA. Previously Ecasound had 
always set the xfer_align to 1.

Anyways, right after the release I got an error report (from Pierre, 
cc'ed) about bad glitches in audio with the new release, and the problem 
now appears to be deprecation of set_xfer_align. To summarize:

  - app relies on xfer_align=1, and has previously set it explicitly
  - in kernels before 2.6.25, the xfer_align is initialized to
    period_size in pcm_native.c and to 1 in pcm_oss.c; but in 2.6.25
    the field was removed altogether:
    http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=d948035a928400ae127c873fbf771389bee18949
  - similar change was done to alsa-lib 1.0.16:
    http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=cf15e49d8460d9b56005d8c49faa064de3649cef

Now the problematic combination is:
  - new application (not anymore calling set_xfer_align())
  - old alsa-lib and kernel (still initializing xfer_size)
  - application used with an ALSA PCM that is strict
    about what period-sizes can be used (e.g. in the specific
    case we found out, ALSA PCM wouldn't accept a power-of-two
    period size)

This is common enough that some workaround is needed in apps, an in 
Ecasound's case case, I'll add some ifdef-magic to 2.7.1 so that 
xfer_align is still set if compiled against an older alsa-lib. That should 
cover majority of the cases...
