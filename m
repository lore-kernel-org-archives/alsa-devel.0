From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: alsa-utils 1.1.8: axfer tests take ages tu run.
Date: Sun, 27 Jan 2019 12:44:38 +0900
Message-ID: <20190127034438.GB7590@workstation>
References: <20190126144922.nim532ciqslpaahb@toy.home.lxtec.de>
 <20190126160432.eatvt2fyh4cdf5at@toy.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CBEA0267454
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 04:44:44 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id y126so6475226pfb.4
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 19:44:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190126160432.eatvt2fyh4cdf5at@toy.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Jan 26, 2019 at 05:04:32PM +0100, Elimar Riesebieter wrote:
> * Elimar Riesebieter <riesebie@lxtec.de> [2019-01-26 15:49 +0100]:
> 
> > Hi,
> > 
> > what are the tests in alsa-utils-1.1.8/axfer/test/ good for? mapper-test and
> > container-test are running very long time. I Can't find any docu in
> > the source? If the need as long as on my 8-core the source is not
> > ready for distribution, though.
> 
>  container-test took 44min but passed!

It's expected.

The execution time of unit tests for axfer is file I/O bound, thus
it's independent of processors. However, I guess it takes 20-50 minutes
to finish all iterations.


I design the 'container-test' to iterate a set of building/parsing
content of media container with memory comparison for 635,904 times.
Each trial consists of the different combination of parameters
described below:

* buffer type for audio data frame (=2)
 * linear buffer and interleaved for SND_PCM_ACCESS_MMAP_INTERLEAVED
 * linear buffer and non-interleaved for SND_PCM_ACCESS_MMAP_NONINTERLEAVED
* type of media container and format of audio data frame (19 + 7 + 4 + 39 = 69)
 * 19 formats for RIFF/Wave container
 * 7 formats for AU container
 * 4 formats for VOC container
 * 39 formats for raw container
* the number of samples in an audio data frame (=128)
 * 1-128
* the number of audio data frames in buffer (=6)
 * 23
 * 1047
 * 2071
 * 3095
 * 4119
 * 4500
 * (23-4500 with 1024 step)
* the number of audio data frames per second (=6)
 * 44.1kHz
 * 48.0
 * 88.2
 * 96.0
 * 176.4
 * 192.0

When building/parsing media container, each implementation of media
container executes I/Os to actual files.


Like container-test, the 'mapper-test' iterates a set of muxing/demuxing
between the buffers of audio data frame and the containers with memory
comparison for 10,752 times. Each trial consists of the different
combination of parameters described below

* buffer type for audio data frame (=4)
 * linear buffer and interleaved for SND_PCM_ACCESS_MMAP_INTERLEAVED
 * linear buffer and non-interleaved for SND_PCM_ACCESS_MMAP_NONINTERLEAVED
 * linear buffer and interleaved for SND_PCM_ACCESS_RW_INTERLEAVED
 * vector buffer and noninterleaved for SND_PCM_ACCESS_RW_NONINTERLEAVED
* type of media container and format of audio data frame (=7)
 * 7 formats for RIFF/Wave
* the number of samples in an audio data frame (=32)
 * 1-32
* the number of audio data frames in buffer (=6)
 * 23
 * 1047
 * 2071
 * 3095
 * 4119
 * 4500
 * (23-4500 with 1024 step)
* the number of audio data frames per second (=1)
 * 48.0 kHz
* type of mapper (=2)
 * single
 * multiple

When muxing/demuxing for buffer of audio data frame, it uses internal
implementation of RIFF/Wave container, thus executes I/Os to actual
files.


I think it preferable to shorten the execution time of each unit test;
e.g. several minutes at maximum, however the purpose of unit test is to
detect bugs in advance and this program handles audio data frame between
the several types of buffer for I/O to sound device and the several
types of media container with combinations of many parameters. At
present it's reasonable to takes such long time to finish the tests.

Of course, we can shorten the duration time by eliminating the range
of parameters. Actually I've investigated to reduce iteration and reduce
for the number of audio data frames in buffer by 6 options. But any
reasonable explanation except for the duration time is required to be
worth for it, IMO.


Thanks

Takashi Sakamoto
