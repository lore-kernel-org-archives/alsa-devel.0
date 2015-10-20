From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 20 Oct 2015 09:39:07 +0200
Message-ID: <20151020093907.033831d3@kant>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013161516.27cb80cc@kant>
 <5624FA84.70208@sakamocchi.jp>
 <20151019233640.GB8953@marvin.atrad.com.au>
 <56258FE6.9000304@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id E430C2605E8
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 09:39:08 +0200 (CEST)
In-Reply-To: <56258FE6.9000304@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 20 Takashi Sakamoto wrote:
> When using polkit correctly, I guess users doesn't need to join in
> 'audio' group, so as PulseAudio achieved with polkit.

With regard to access to /dev/fw* files, this is true with the existing
FFADO rules too.  60-ffado.rules sets ENV{ID_FFADO}="1", and
consolekit's 70-udev-acl.rules recognizes ID_FFADO and runs udev-acl on
the device.

(I.e. the current "console" owner is granted access to the character
device file via access control list (ACL), which is a mechanism in
parallel to Unix permission flags.)

The console owner policy and ACL mechanism are not a complete replacement
for the group mechanism though:
  - There may be headless systems and other occasions at which the audio
    user is not console owner.
  - Processes involved in capture or playback, i.e. applications beyond
    mixers, may require realtime scheduling class privilege and memlocking
    privilege, which are traditionally configured for Unix groups and
    users (typically for a group).  Not sure whether a mechanism exists
    which can implement a console owner policy for realtime and memlock
    privileges.
-- 
Stefan Richter
-=====-===== =-=- =-=--
http://arcgraph.de/sr/
