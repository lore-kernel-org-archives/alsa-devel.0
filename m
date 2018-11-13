From: GitHub pull_request - opened <github@alsa-project.org>
Subject: alsa-utils: axfer: rewrite aplay,
	adding 'timer-based scheduling' option
Date: Tue, 13 Nov 2018 07:24:59 +0100 (CET)
Message-ID: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
References: <1542090296222634077-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8965C267839
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:24:56 +0100 (CET)
In-Reply-To: <1542090296222634077-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #3 was opened from takaswie:

Hi,

This patchset is an updated version of my previous RFCv3, and for
merging to upstream.

[alsa-devel] [RFCv3][PATCH 00/39] axfer: rewrite aplay, adding 'timer-based scheduling' option
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-October/125961.html

As I noted in RFCv3, some patches are dropped in this patchset, due to
some technical issues. In detail, please refer to RFCv3.

Changes from RFCv3:
 - rename scheduling option to 'sched-model'
 - improve waiter implementation and add support for select(2)
 - categorize supported options as common and backend-dependent
 - release alsa-lib configuration space at the end of runtime
 - valgrind test and fix some memory leaks
 - add 'frame-cache' internal interface to share implementation by
   several backends.
 - add 'libffado' backend just for technical preview (linkage of this
   library brings problems. Please refet to patch comment.)

I apologize but in this time I don't prepare any help document and
manuals as well as RFCv3. Let me put them to a part of task for this
development period.

Regards

Takashi Sakamoto (35):
  axfer: add an entry point for this command
  axfer: add a sub-command to print list of PCMs/devices
  axfer: add a common interface to handle a file with audio-specific
    data format
  axfer: add support for a container of Microsoft/IBM RIFF/Wave format
  axfer: add support for a container of Sparc AU format
  axfer: add support for a container of Creative Tech. voice format
  axfer: add support for a container of raw data
  axfer: add unit test for container interface
  axfer: add a common interface to align data frames on different layout
  axfer: add support for a mapper for single target
  axfer: add support for a mapper for multiple target
  axfer: add a unit test for mapper interface
  axfer: add a common interface to transfer data frames
  axfer: add a parser for command-line options
  axfer: add support to transfer data frames by alsa-lib PCM APIs
  axfer: add support for blocking data transmission operation of
    alsa-lib PCM API
  axfer: add a sub-command to transfer data frames
  axfer: add informative output and an option to suppress it
  axfer: add an option to dump available hardware parameters
  axfer: add options related to duration and obsolete '--max-file-size'
    option
  axfer: add an option to finish transmission at XRUN
  axfer: add support for non-blocking operation
  axfer: add support for MMAP PCM operation
  axfer: add an option to suppress event waiting
  axfer: add options for buffer arrangement
  axfer: add options for software parameters of PCM substream
  axfer: add options for plugins in alsa-lib
  axfer: add a common interface of waiter for I/O event notification
  axfer: add an option for waiter type
  axfer: add an implementation of waiter for poll(2)
  axfer: add an implementation of waiter for select(2)
  axfer: add an implementation of waiter for epoll(7)
  axfer: add support for timer-based scheduling model with MMAP
    operation
  axfer: obsolete some unimplemented options
  axfer: add support for libffado transmission backend

```
 Makefile.am                       |   2 +-
 axfer/Makefile.am                 |  62 +++
 axfer/container-au.c              | 203 +++++++
 axfer/container-raw.c             |  66 +++
 axfer/container-riff-wave.c       | 575 +++++++++++++++++++
 axfer/container-voc.c             | 833 +++++++++++++++++++++++++++
 axfer/container.c                 | 457 +++++++++++++++
 axfer/container.h                 | 126 +++++
 axfer/frame-cache.c               | 111 ++++
 axfer/frame-cache.h               |  47 ++
 axfer/main.c                      | 229 ++++++++
 axfer/mapper-multiple.c           | 259 +++++++++
 axfer/mapper-single.c             | 191 +++++++
 axfer/mapper.c                    | 150 +++++
 axfer/mapper.h                    |  87 +++
 axfer/misc.h                      |  19 +
 axfer/subcmd-list.c               | 234 ++++++++
 axfer/subcmd-transfer.c           | 467 ++++++++++++++++
 axfer/subcmd.h                    |  18 +
 axfer/test/Makefile.am            |  31 ++
 axfer/test/container-test.c       | 299 ++++++++++
 axfer/test/generator.c            | 260 +++++++++
 axfer/test/generator.h            |  47 ++
 axfer/test/mapper-test.c          | 491 ++++++++++++++++
 axfer/waiter-epoll.c              | 107 ++++
 axfer/waiter-poll.c               |  45 ++
 axfer/waiter-select.c             | 100 ++++
 axfer/waiter.c                    | 104 ++++
 axfer/waiter.h                    |  61 ++
 axfer/xfer-libasound-irq-mmap.c   | 282 ++++++++++
 axfer/xfer-libasound-irq-rw.c     | 427 ++++++++++++++
 axfer/xfer-libasound-timer-mmap.c | 455 +++++++++++++++
 axfer/xfer-libasound.c            | 898 ++++++++++++++++++++++++++++++
 axfer/xfer-libasound.h            |  92 +++
 axfer/xfer-libffado.c             | 555 ++++++++++++++++++
 axfer/xfer-options.c              | 589 ++++++++++++++++++++
 axfer/xfer.c                      | 254 +++++++++
 axfer/xfer.h                      | 115 ++++
 configure.ac                      |  15 +-
 39 files changed, 9361 insertions(+), 2 deletions(-)
 create mode 100644 axfer/Makefile.am
 create mode 100644 axfer/container-au.c
 create mode 100644 axfer/container-raw.c
 create mode 100644 axfer/container-riff-wave.c
 create mode 100644 axfer/container-voc.c
 create mode 100644 axfer/container.c
 create mode 100644 axfer/container.h
 create mode 100644 axfer/frame-cache.c
 create mode 100644 axfer/frame-cache.h
 create mode 100644 axfer/main.c
 create mode 100644 axfer/mapper-multiple.c
 create mode 100644 axfer/mapper-single.c
 create mode 100644 axfer/mapper.c
 create mode 100644 axfer/mapper.h
 create mode 100644 axfer/misc.h
 create mode 100644 axfer/subcmd-list.c
 create mode 100644 axfer/subcmd-transfer.c
 create mode 100644 axfer/subcmd.h
 create mode 100644 axfer/test/Makefile.am
 create mode 100644 axfer/test/container-test.c
 create mode 100644 axfer/test/generator.c
 create mode 100644 axfer/test/generator.h
 create mode 100644 axfer/test/mapper-test.c
 create mode 100644 axfer/waiter-epoll.c
 create mode 100644 axfer/waiter-poll.c
 create mode 100644 axfer/waiter-select.c
 create mode 100644 axfer/waiter.c
 create mode 100644 axfer/waiter.h
 create mode 100644 axfer/xfer-libasound-irq-mmap.c
 create mode 100644 axfer/xfer-libasound-irq-rw.c
 create mode 100644 axfer/xfer-libasound-timer-mmap.c
 create mode 100644 axfer/xfer-libasound.c
 create mode 100644 axfer/xfer-libasound.h
 create mode 100644 axfer/xfer-libffado.c
 create mode 100644 axfer/xfer-options.c
 create mode 100644 axfer/xfer.c
 create mode 100644 axfer/xfer.h
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/3
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/3.patch
Repository URL: https://github.com/alsa-project/alsa-utils
