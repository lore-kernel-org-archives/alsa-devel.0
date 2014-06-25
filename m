From: =?UTF-8?Q?Roc_Vall=C3=A8s?= <vallesroc@gmail.com>
Subject: alsa-tools 1.0.28 regression with sblive/emu10k1:
 init_live shell script broken.
Date: Wed, 25 Jun 2014 16:37:52 +0000
Message-ID: <CAPq5wtZVZpYvBJ2TK-oG5kEbfc95bz4_nVKxzcWXwGXWnWHQgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F2592619F7
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 18:37:55 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id dc16so1795241qab.1
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 09:37:53 -0700 (PDT)
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

I've recently upgraded to alsa-tools 1.0.28. There's apparently a
regression: live_init, the script that is bundled for sound blaster
live soundcard initialization, has been broken. Without this, the
soundcard can only be used at a very basic level (just 2 speakers, no
equalization or other effects, most inputs unavailable). Reporting
here as the bugtracker is down.


Correct run (1.0.17):
# sh /usr/bin/init_live
#


Broken run (1.0.28):
# /usr/bin/init_live
/usr/bin/init_live: line 49: log: command not found
/usr/bin/init_live: line 51: local: can only be used in a function
/usr/bin/init_live: line 55: [: 0: unary operator expected
/usr/bin/init_live: line 60: runlo10k1: command not found
/usr/bin/init_live: line 62: log: command not found
rename: not enough arguments

Usage:
 rename [options] expression replacement file...

Options:
 -v, --verbose    explain what is being done
 -s, --symlink    act on symlink target

 -h, --help     display this help and exit
 -V, --version  output version information and exit

For more details see rename(1).
/usr/bin/init_live: line 79: log: command not found
/usr/bin/init_live: line 81: runlo10k1: command not found
/usr/bin/init_live: line 84: connect: command not found
/usr/bin/init_live: line 90: log: command not found
/usr/bin/init_live: line 92: runlo10k1: command not found
/usr/bin/init_live: line 95: copy: command not found
/usr/bin/init_live: line 97: local: can only be used in a function
/usr/bin/init_live: line 98: local: can only be used in a function
/usr/bin/init_live: line 100: log: command not found
/usr/bin/init_live: line 103: runlo10k1: command not found
/usr/bin/init_live: line 105: connect: command not found
/usr/bin/init_live: line 108: volume: command not found
/usr/bin/init_live: line 110: local: can only be used in a function
/usr/bin/init_live: line 111: local: can only be used in a function
/usr/bin/init_live: line 112: local: can only be used in a function
/usr/bin/init_live: line 113: local: can only be used in a function
/usr/bin/init_live: line 115: log: command not found
/usr/bin/init_live: line 118: runlo10k1: command not found
/usr/bin/init_live: line 120: connect: command not found
/usr/bin/init_live: line 123: master_volume: command not found
/usr/bin/init_live: line 125: local: can only be used in a function
/usr/bin/init_live: line 126: local: can only be used in a function
/usr/bin/init_live: line 127: local: can only be used in a function
/usr/bin/init_live: line 128: local: can only be used in a function
/usr/bin/init_live: line 130: log: command not found
/usr/bin/init_live: line 133: runlo10k1: command not found
/usr/bin/init_live: line 135: connect: command not found
/usr/bin/init_live: line 138: switch: command not found
/usr/bin/init_live: line 140: local: can only be used in a function
/usr/bin/init_live: line 141: local: can only be used in a function
/usr/bin/init_live: line 142: local: can only be used in a function
/usr/bin/init_live: line 144: log: command not found
/usr/bin/init_live: line 148: runlo10k1: command not found
/usr/bin/init_live: line 150: connect: command not found
/usr/bin/init_live: line 153: switch_2x2: command not found
/usr/bin/init_live: line 155: local: can only be used in a function
/usr/bin/init_live: line 156: local: can only be used in a function
/usr/bin/init_live: line 157: local: can only be used in a function
/usr/bin/init_live: line 158: local: can only be used in a function
/usr/bin/init_live: line 160: log: command not found
/usr/bin/init_live: line 163: runlo10k1: command not found
/usr/bin/init_live: line 165: connect: command not found
/usr/bin/init_live: line 166: connect: command not found
/usr/bin/init_live: line 169: switch_5x2: command not found
/usr/bin/init_live: line 171: local: can only be used in a function
/usr/bin/init_live: line 172: local: can only be used in a function
/usr/bin/init_live: line 173: local: can only be used in a function
/usr/bin/init_live: line 174: local: can only be used in a function
/usr/bin/init_live: line 176: log: command not found
/usr/bin/init_live: line 179: runlo10k1: command not found
/usr/bin/init_live: line 181: connect: command not found
/usr/bin/init_live: line 182: connect: command not found
/usr/bin/init_live: line 185: master_switch: command not found
/usr/bin/init_live: line 187: local: can only be used in a function
/usr/bin/init_live: line 188: local: can only be used in a function
/usr/bin/init_live: line 189: local: can only be used in a function
/usr/bin/init_live: line 190: local: can only be used in a function
/usr/bin/init_live: line 192: log: command not found
/usr/bin/init_live: line 195: runlo10k1: command not found
/usr/bin/init_live: line 197: connect: command not found
/usr/bin/init_live: line 200: playback: command not found
/usr/bin/init_live: line 205: log: command not found
/usr/bin/init_live: line 208: switch: command not found
/usr/bin/init_live: line 209: volume: command not found
/usr/bin/init_live: line 211: add_output: command not found
/usr/bin/init_live: line 214: playback_noswitch: command not found
/usr/bin/init_live: line 219: log: command not found
/usr/bin/init_live: line 222: volume: command not found
/usr/bin/init_live: line 224: add_output: command not found
/usr/bin/init_live: line 227: capture: command not found
/usr/bin/init_live: line 232: log: command not found
/usr/bin/init_live: line 235: switch: command not found
/usr/bin/init_live: line 236: volume: command not found
/usr/bin/init_live: line 238: connect: command not found
/usr/bin/init_live: line 241: capture_noswitch: command not found
/usr/bin/init_live: line 246: log: command not found
/usr/bin/init_live: line 249: volume: command not found
/usr/bin/init_live: line 251: connect: command not found
/usr/bin/init_live: line 254: master: command not found
/usr/bin/init_live: line 256: local: can only be used in a function
/usr/bin/init_live: line 257: local: can only be used in a function
/usr/bin/init_live: line 258: local: can only be used in a function
/usr/bin/init_live: line 260: log: command not found
/usr/bin/init_live: line 263: master_volume: command not found
/usr/bin/init_live: line 264: master_switch: command not found
/usr/bin/init_live: line 267: dump_patches: command not found
