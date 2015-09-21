From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
	command line tool
Date: Mon, 21 Sep 2015 07:33:28 +0100
Message-ID: <1442817208.2612.6.camel@loki>
References: <cover.1442298607.git.han.lu@intel.com>
 <s5hy4g2xt03.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FD56260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 08:33:32 +0200 (CEST)
In-Reply-To: <s5hy4g2xt03.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: han.lu@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Caleb Crome <caleb@crome.org>, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-09-19 at 18:40 +0200, Takashi Iwai wrote:
> Hi,
> 
> I'm currently traveling on vacation and have little time to check
> through the patchset and join the discussion.  I'll take a closer look
> in the next week.
> 

No worries. This gives us time to merge in Caleb's sine wave generator
patch and we can then send a V2 series.

Thanks

Liam

> 
> thanks,
> 
> Takashi
> 
> 
> On Tue, 15 Sep 2015 09:00:16 +0200,
> <han.lu@intel.com> wrote:
> > 
> > From: "Lu, Han" <han.lu@intel.com>
> > 
> > BAT (Basic Audio Tester) is a simple command line utility intended
> > to automate audio driver and sound server QA testing with no human
> > interaction.
> > 
> > BAT works by playing an audio stream and capturing the same stream
> > in either a digital or analog loopback. It then compares the captured
> > stream to the original to determine if the testcase passes or fails.
> > 
> > The main idea of frequency detecting is:
> > The analysis function reads data from wav file, run fft against the data
> > to get magnitude of frequency vectors, and then calculates the average
> > value and standard deviation of frequency vectors. After that, we define
> > a threshold:
> >     threshold = 3 * standard_deviation + average_value
> > Frequencies with amplitude larger than threshold will be recognized as
> > a peak, and the frequency with largest peak value will be recognized as
> > a detected frequency.
> > BAT then compares the detected frequency to target frequency, to decide
> > if the detecting passes or fails.
> > 
> > BAT supports 4 working modes:
> >   1. single line playback;
> >   2. single line capture and analysis;
> >   3. playback and capture in loop, and analyze captured data;
> >   4. local analyze without actual playback or capture.
> > BAT will check devices input by user to decide which mode to use.
> > BAT will create threads for playback and record, and will run spectrum
> > analysis for mode 2, 3 or 4.
> > 
> > Lu, Han (7):
> >   BAT: Add initial functions
> >   BAT: Add common definitions and functions
> >   BAT: Add playback and record functions
> >   BAT: Add signal generator
> >   BAT: Add converting functions
> >   BAT: Add spectrum analysis functions
> >   BAT: Add Makefile and configures
> > 
> >  Makefile.am     |   3 +
> >  bat/Makefile.am |  14 ++
> >  bat/alsa.c      | 618 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  bat/alsa.h      |  20 ++
> >  bat/analyze.c   | 314 ++++++++++++++++++++++++++++
> >  bat/analyze.h   |  16 ++
> >  bat/bat.c       | 608 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  bat/common.c    | 198 ++++++++++++++++++
> >  bat/common.h    | 169 ++++++++++++++++
> >  bat/convert.c   | 113 +++++++++++
> >  bat/convert.h   |  23 +++
> >  bat/signal.c    |  88 ++++++++
> >  configure.ac    |  19 +-
> >  13 files changed, 2202 insertions(+), 1 deletion(-)
> >  create mode 100644 bat/Makefile.am
> >  create mode 100644 bat/alsa.c
> >  create mode 100644 bat/alsa.h
> >  create mode 100644 bat/analyze.c
> >  create mode 100644 bat/analyze.h
> >  create mode 100644 bat/bat.c
> >  create mode 100644 bat/common.c
> >  create mode 100644 bat/common.h
> >  create mode 100644 bat/convert.c
> >  create mode 100644 bat/convert.h
> >  create mode 100644 bat/signal.c
> > 
> > -- 
> > 1.9.1
> > 
> > 


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
