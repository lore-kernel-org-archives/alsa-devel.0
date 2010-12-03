From: sudarshan.bisht@nokia.com
Subject: [PATCH 0/2] Fixed issues/defects reported by Coverity
	tool.
Date: Fri,  3 Dec 2010 14:06:14 +0200
Message-ID: <1291377976-9842-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id CCDAC103B29
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 13:06:14 +0100 (CET)
Received: from localhost.localdomain (esdhcp04044.research.nokia.com
	[172.21.40.44])
	by mgw-da01.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	oB3C6C8Q001524
	for <alsa-devel@alsa-project.org>; Fri, 3 Dec 2010 14:06:13 +0200
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
List-Id: alsa-devel@alsa-project.org

From: Sudarshan <sudarshan.bisht@nokia.com>

	
	Coverity Static Analysis helps developers find hard-to-spot, 
yet potentially crash-causing defects early in the development phase,
reducing the cost,time, and risk of software errors.


* First patch here is just a cosmetic one as it removes 
tabs and trailing whitespaces from the code.

* Second patch has got fixes for some minor issues/defects 
reported by Coverity tool and these fixes can prevent memory 
leaks and crashes in some cases. It also has some whitespaces 
and tabs removal differences, please ignore them.

Sudarshan (1):
  alsa-lib: Removed trailing whitespaces as per pulseaudio coding
    guidelines.

bisht (1):
  alsa-lib: Coverity tool has picked some minor issues in alsa-lib
    source code, fixed them.

 aserver/aserver.c              | 1813 +++++++-------
 modules/mixer/simple/sbase.c   |  837 ++++----
 modules/mixer/simple/sbasedl.c |  126 +-
 src/alisp/alisp.c              |    4 +-
 src/alisp/alisp_snd.c          | 1493 ++++++------
 src/conf.c                     | 5117 ++++++++++++++++++++--------------------
 src/control/control_hw.c       |  597 +++---
 src/control/control_shm.c      | 1019 ++++----
 src/control/setup.c            |    3 +-
 src/hwdep/hwdep.c              |  496 ++--
 src/mixer/mixer.c              |  962 ++++----
 src/mixer/simple_abst.c        |    1 +
 src/mixer/simple_none.c        |   15 +-
 src/pcm/pcm.c                  | 4812 +++++++++++++++++++-------------------
 src/pcm/pcm_file.c             | 1452 ++++++------
 src/pcm/pcm_hooks.c            |  937 ++++----
 src/pcm/pcm_ladspa.c           | 2284 +++++++++---------
 src/pcm/pcm_local.h            |    3 +-
 src/pcm/pcm_meter.c            | 1634 +++++++-------
 src/pcm/pcm_rate.c             | 2166 +++++++++---------
 src/pcm/pcm_share.c            |   10 +-
 src/pcm/pcm_shm.c              | 1329 ++++++------
 src/pcm/pcm_simple.c           |  404 ++--
 src/rawmidi/rawmidi.c          |    2 +-
 src/rawmidi/rawmidi_virt.c     |    8 +-
 25 files changed, 13782 insertions(+), 13742 deletions(-)
