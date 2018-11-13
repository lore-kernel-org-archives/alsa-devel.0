From: Timo Wischer <twischer@de.adit-jv.com>
Subject: HTTP GIT access to alsa-lib seems to be misaligned
Date: Tue, 13 Nov 2018 11:26:18 +0100
Message-ID: <d0499705-8b84-3761-42f0-f4b3b311c6d0@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 by alsa0.perex.cz (Postfix) with ESMTP id E2C572677E8
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 11:26:29 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

The master branch of

$ git clone http://git.alsa-project.org/http/alsa-lib.git

is a different one as of

$ git clone git://git.alsa-project.org/alsa-lib.git alsa-lib


$ git log --graph --oneline http/master
* dd2f6f8 update README
* 9021f6c samples: make them work well
* eec7186 tests: add a test for client instance of ALSATimer
* c46b9e6 tests: add a test for port instance of ALSASeq
* d6467d9 tests: add a test for client instance of ALSASeq
* 03a8b8b tests: add test for public API of client class of ALSACtl
* 2f94c2d rawmidi; add GObject enumerator for information flags
* ed49bff rawmidi: add GObject enums for stream direction
* 25e37bc rawmidi: add support for GObject enumerations
* 709c4ce timer: add GObject enums for event type of timer instance
* 10c9f2e timer: add GObject flags for paramter flags of timer instance
* 3118597 timer: add GObject flags for flag of global timer instance
* b28e1d7 timer: add GObject enums for type of global timer instance
* 48f904b timer: add GObject enums for slave class of timer instance
* 3bc28ec timer: add GObject enums for device class of timer instance
* 480b358 timer: add support for GObject enumerations

versus

$ git log --graph --oneline origin/master
* 178fe66 utils/alsa.m4: conditionally enable libdl in AM_PATH_ALSA m4 macro
* 9a8d0b0 README.md: add link to www.alsa-project.org
* fa72edc initial version of README.md for github
* 6fbee19 initial version of .travis.yml file
* b420056 pcm: interval: Interpret (x x+1] correctly and return x+1
* 92172ad test/audio_time: remove unused variables
* 956bc15 test: rename code to more approriate mixtest
* 82ae026 test/code: make it work again
* 6852f88 test/latecy: fix typo in tstamp compare
* 6eced6b conf/ucm/Dell-WD15-Dock: Fix incorrect device names
* 3ec6dce Release v1.1.7
* fd13267 ioplug: Fix comment in struct snd_pcm_ioplug
* 60d74ce timer: fix wrong comment to refer to 'SNDRV_TIMER_PSFLG_*'
* 7c5c050 seq: Fix signedness in MIDI encoder/decoder
* a849163 control_hw: Fix issue when applying seccomp policy
* 040cfea conf/ucm: bytcr-rt5640: Improve human readable input/output names


@Takashi The latest commit of http/master is yours. May be you have an 
idea how to solve this issue.

-- 
Best regards
*Timo Wischer*
Engineering Software Base (ADITG/ESB)

Tel. +49 5121 49 6938
