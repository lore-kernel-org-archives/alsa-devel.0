From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Mon, 28 Feb 2011 17:20:41 +0100
Message-ID: <4D6BCB59.30709@drcomp.erfurt.thur.de>
References: <4D69A0FC.60400@localhost> <20110227111708.GK15327@ltw.loris.tv>
	<4D6AA448.7050401@localhost> <4D6AE436.6000201@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FC58103800
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 17:20:56 +0100 (CET)
In-Reply-To: <4D6AE436.6000201@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Craig Bourne <craigbourne@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/28/11 00:54, Fernando Lopez-Lezcano wrote:

> But one of my users (in Planet CCRMA) still has problems with his 9652,
> apparently the output labels for that card are missing and that is
> confirmed by looking at the source (his card works fine with the 1.0.23
> hdspmixer). I applied all your patches to current git except for the

Indeed. There have never been labels, and now it's crashing, most likely
because of dereferencing the non-existing label array.

Do you mind to try this patch? Maybe it's enough. If Craig feels happy
to do some remote try&error, I can sort this out with him.

Right now, I'm simply assigning a stupid "1", "2" .. "64" channel
naming, but maybe Craig can provide us with the correct output labels? I
don't have access to a H9652, so I don't have the slightest clue how the
ports are named. ;)


HTH

diff --git a/hdspmixer/src/HDSPMixerOutput.cxx
b/hdspmixer/src/HDSPMixerOutput.cxx
index 05a126c..0d8ea5c 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -262,6 +262,7 @@ void HDSPMixerOutput::setLabels()
       }
     } else {
       fprintf(stderr, "Unknown card type for output labels\n");
+      labels_input = labels_playback = labels_madi_ss;
     }
 }
