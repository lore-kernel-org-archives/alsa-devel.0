From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Tue, 15 Sep 2015 20:23:55 -0700
Message-ID: <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
References: <cover.1442298607.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id D04B82604EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 05:24:16 +0200 (CEST)
Received: by ykdg206 with SMTP id g206so206532091ykd.1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 20:24:15 -0700 (PDT)
In-Reply-To: <cover.1442298607.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: bernard.gautier@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Han,
  This is great.  Audio testing is something near and dear to my heart
:-)  Well, if not heart, at least my profession.  One test that we've
been using a long time (that I got from the Audio Anecdotes books) is
to do a ramp test.   In fact, we strongly suggest our customers
(almost require them) to complete the test successfully before trying
to integrate our software (high end mic array and acoustic echo
cancellation software).

So, the test is pretty simple:  Set up a hardware  (digital) loopback
between output and input.  Then send out a 'ramp', i.e. just keep a
counter that increments each frame, and send out the counter value out
to the audio port and watch the values that come back.  In our work
it's quite important that every sample come back bit-perfect with no
samples added or dropped.

Once this test is up and running, you then bang on the system to
ensure the audio stream doesn't break even under heavy load.

After the test has been up and running for some days without a bit
lost, then you can be pretty sure it's safe to integrate the AEC
software.

The benefit of the ramp test is that it's a 100% bit-perfect test.  No
analysis required, simple pass or fail The drawback is that it doesn't
work with analog loopback, which your test will.

For analog testing there may be other tests that could be useful too,
like an audio PLL plus comparator to test in the time domain or a
million other possibilities, but it depends on what failure modes
actually happen.

What kind of failure modes do we see in linux?    Do all failures end
up with underrun or overrun, or are there more subtle errors, like
frames lost or gained without the software knowing about it?  Or
perhaps whole blocks that get duplicated or deleted?

i.e. is the user level always notified of an error?

>From one of our customers that runs on Windows, it seems that there
are million ways Windows messes with audio and can wreck the audio
without telling you, but I haven't seen too many (or any) like that
with Linux?






On Tue, Sep 15, 2015 at 12:00 AM,  <han.lu@intel.com> wrote:
> From: "Lu, Han" <han.lu@intel.com>
>
> BAT (Basic Audio Tester) is a simple command line utility intended
> to automate audio driver and sound server QA testing with no human
> interaction.
>
> BAT works by playing an audio stream and capturing the same stream
> in either a digital or analog loopback. It then compares the captured
> stream to the original to determine if the testcase passes or fails.
>
> The main idea of frequency detecting is:
> The analysis function reads data from wav file, run fft against the data
> to get magnitude of frequency vectors, and then calculates the average
> value and standard deviation of frequency vectors. After that, we define
> a threshold:
>     threshold = 3 * standard_deviation + average_value
> Frequencies with amplitude larger than threshold will be recognized as
> a peak, and the frequency with largest peak value will be recognized as
> a detected frequency.
> BAT then compares the detected frequency to target frequency, to decide
> if the detecting passes or fails.
>
> BAT supports 4 working modes:
>   1. single line playback;
>   2. single line capture and analysis;
>   3. playback and capture in loop, and analyze captured data;
>   4. local analyze without actual playback or capture.
> BAT will check devices input by user to decide which mode to use.
> BAT will create threads for playback and record, and will run spectrum
> analysis for mode 2, 3 or 4.
>
> Lu, Han (7):
>   BAT: Add initial functions
>   BAT: Add common definitions and functions
>   BAT: Add playback and record functions
>   BAT: Add signal generator
>   BAT: Add converting functions
>   BAT: Add spectrum analysis functions
>   BAT: Add Makefile and configures
>
>  Makefile.am     |   3 +
>  bat/Makefile.am |  14 ++
>  bat/alsa.c      | 618 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  bat/alsa.h      |  20 ++
>  bat/analyze.c   | 314 ++++++++++++++++++++++++++++
>  bat/analyze.h   |  16 ++
>  bat/bat.c       | 608 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  bat/common.c    | 198 ++++++++++++++++++
>  bat/common.h    | 169 ++++++++++++++++
>  bat/convert.c   | 113 +++++++++++
>  bat/convert.h   |  23 +++
>  bat/signal.c    |  88 ++++++++
>  configure.ac    |  19 +-
>  13 files changed, 2202 insertions(+), 1 deletion(-)
>  create mode 100644 bat/Makefile.am
>  create mode 100644 bat/alsa.c
>  create mode 100644 bat/alsa.h
>  create mode 100644 bat/analyze.c
>  create mode 100644 bat/analyze.h
>  create mode 100644 bat/bat.c
>  create mode 100644 bat/common.c
>  create mode 100644 bat/common.h
>  create mode 100644 bat/convert.c
>  create mode 100644 bat/convert.h
>  create mode 100644 bat/signal.c
>
> --
> 1.9.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
