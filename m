From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 00/38] alsa-utils: axfer: rewrite aplay
Date: Tue, 19 Sep 2017 09:43:40 +0900
Message-ID: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E4B32266DBB
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This large patchset is to introduce a new command, named as 'axfer' (ALSA
transfer). This comes from my work to rewrite aplay. Initial patchset was
already posted as RFCv1.

[alsa-devel][PATCH 00/23] alsa-utils: rewrite aplay
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/124132.html

Unlike the initial patchset, this patchset includes support for the most of
options in aplay, and simple unit tests for functionalities to handle data
frames for files.

At patch 17, transmission of data frame with blocking mode is supported.
You can actually test playback/capture.
 * axfer: add a sub-command to transfer data frames

At patch 24, transmission with non-blocking mode is supported.
 * axfer: add support for non-blocking operation

At patch 25, transmission by MMAP operation is supported.
 * axfer: add support for MMAP PCM operation

Between patch 30-36, some minor features are supported, but they includes
own issues. I'd like to abandon them in future patchset.
 * axfer: add an option to support volume unit meter
 * axfer: add a unit test for vumeter calculation
 * axfer: add an option for formatted filename
 * axfer: add an option to handle key events
 * axfer: add a parser for channel map API
 * axfer: add a feature to generate a file for process id
 * axfer: obsolete some test options

At patch 37/38, an integration to select waiter type is added. You can
select one of poll(2) and epoll(2) to wait for I/O event notification.

At present, I found some problems of this program:
 * When MMAP operation is used for PCM nodes with 'plug' plugin, XRUN occurs
   for capture and noisy sound for playback. I don't found this in the other
   operations such as blocking.
 * When using two axfer processes for capture/playback with pipe, some frames
   are truncated in the end of playback.

I leave some tasks such as documentation and localization, but this patchset
covers major use cases, I think.


Regards

Takashi Sakamoto (38):
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
  axfer: add a parser for command-line options
  axfer: add a common interface to transfer data frames
  axfer: add support to transfer data frames by alsa-lib PCM APIs
  axfer: add support for blocking data transmission operation of
    alsa-lib PCM API
  axfer: add a sub-command to transfer data frames
  axfer: add informative output and an option to suppress it
  axfer: add an option to dump available hardware parameters
  axfer: add options related to duration and obsolete '--max-file-size'
    option
  axfer: add an option to finish transmission at XRUN
  axfer: add a common interface of waiter for I/O event notification
  axfer: add support of waiter for poll(2)
  axfer: add support for non-blocking operation
  axfer: add support for MMAP PCM operation
  axfer: add an option to suppress event waiting
  axfer: add options for buffer arrangement
  axfer: add options for software parameters of PCM substream
  axfer: add options for plugins in alsa-lib
  axfer: add an option to support volume unit meter
  axfer: add a unit test for vumeter calculation
  axfer: add an option for formatted filename
  axfer: add an option to handle key events
  axfer: add a parser for channel map API
  axfer: add a feature to generate a file for process id
  axfer: obsolete some test options
  axfer: add an implementation of waiter for epoll(7)
  axfer: add an option for waiter type

 Makefile.am                     |   2 +-
 axfer/Makefile.am               |  60 +++
 axfer/container-au.c            | 207 +++++++++
 axfer/container-raw.c           |  66 +++
 axfer/container-riff-wave.c     | 581 ++++++++++++++++++++++++
 axfer/container-voc.c           | 843 +++++++++++++++++++++++++++++++++++
 axfer/container.c               | 470 ++++++++++++++++++++
 axfer/container.h               | 126 ++++++
 axfer/key-event.c               | 121 +++++
 axfer/key-event.h               |  19 +
 axfer/main.c                    | 194 ++++++++
 axfer/mapper-multiple.c         | 271 +++++++++++
 axfer/mapper-single.c           | 195 ++++++++
 axfer/mapper.c                  | 152 +++++++
 axfer/mapper.h                  |  87 ++++
 axfer/misc.h                    |  16 +
 axfer/options.c                 | 963 ++++++++++++++++++++++++++++++++++++++++
 axfer/options.h                 |  83 ++++
 axfer/subcmd-list.c             | 234 ++++++++++
 axfer/subcmd-transfer.c         | 520 ++++++++++++++++++++++
 axfer/subcmd.h                  |  18 +
 axfer/test/Makefile.am          |  39 ++
 axfer/test/container-test.c     | 299 +++++++++++++
 axfer/test/generator.c          | 260 +++++++++++
 axfer/test/generator.h          |  47 ++
 axfer/test/mapper-test.c        | 491 ++++++++++++++++++++
 axfer/test/vumeter-test.c       | 128 ++++++
 axfer/vumeter.c                 | 565 +++++++++++++++++++++++
 axfer/vumeter.h                 |  56 +++
 axfer/waiter-epoll.c            |  81 ++++
 axfer/waiter-poll.c             |  68 +++
 axfer/waiter.c                  |  84 ++++
 axfer/waiter.h                  |  52 +++
 axfer/xfer-libasound-irq-mmap.c | 224 ++++++++++
 axfer/xfer-libasound-irq-rw.c   | 518 +++++++++++++++++++++
 axfer/xfer-libasound.c          | 682 ++++++++++++++++++++++++++++
 axfer/xfer-libasound.h          |  57 +++
 axfer/xfer.c                    | 191 ++++++++
 axfer/xfer.h                    |  76 ++++
 configure.ac                    |   3 +-
 40 files changed, 9147 insertions(+), 2 deletions(-)
 create mode 100644 axfer/Makefile.am
 create mode 100644 axfer/container-au.c
 create mode 100644 axfer/container-raw.c
 create mode 100644 axfer/container-riff-wave.c
 create mode 100644 axfer/container-voc.c
 create mode 100644 axfer/container.c
 create mode 100644 axfer/container.h
 create mode 100644 axfer/key-event.c
 create mode 100644 axfer/key-event.h
 create mode 100644 axfer/main.c
 create mode 100644 axfer/mapper-multiple.c
 create mode 100644 axfer/mapper-single.c
 create mode 100644 axfer/mapper.c
 create mode 100644 axfer/mapper.h
 create mode 100644 axfer/misc.h
 create mode 100644 axfer/options.c
 create mode 100644 axfer/options.h
 create mode 100644 axfer/subcmd-list.c
 create mode 100644 axfer/subcmd-transfer.c
 create mode 100644 axfer/subcmd.h
 create mode 100644 axfer/test/Makefile.am
 create mode 100644 axfer/test/container-test.c
 create mode 100644 axfer/test/generator.c
 create mode 100644 axfer/test/generator.h
 create mode 100644 axfer/test/mapper-test.c
 create mode 100644 axfer/test/vumeter-test.c
 create mode 100644 axfer/vumeter.c
 create mode 100644 axfer/vumeter.h
 create mode 100644 axfer/waiter-epoll.c
 create mode 100644 axfer/waiter-poll.c
 create mode 100644 axfer/waiter.c
 create mode 100644 axfer/waiter.h
 create mode 100644 axfer/xfer-libasound-irq-mmap.c
 create mode 100644 axfer/xfer-libasound-irq-rw.c
 create mode 100644 axfer/xfer-libasound.c
 create mode 100644 axfer/xfer-libasound.h
 create mode 100644 axfer/xfer.c
 create mode 100644 axfer/xfer.h

-- 
2.11.0
