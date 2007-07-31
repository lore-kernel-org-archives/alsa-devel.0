From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Known STAC9200 input selection problem?
Date: Tue, 31 Jul 2007 09:28:10 -0300
Message-ID: <5f52f6d70707310528o32548b8fsf40d5b12f096f7d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F6EB24375
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 14:28:11 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so411571fka
	for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2007 05:28:10 -0700 (PDT)
Content-Disposition: inline
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

Hi,

I've received the following bug report about problems in the internal
mic of a Dell Latitude D820 (STAC9200). Is this a known problem? The
used tested it with a fairly updated (but non-HG) driver. I've seen a
similar problem in an HP dx2250 (ALC862) with an outdated ALSA lib,
but this doesn't seem to be the case here.

--- Excerpt of original report follows ---

On laptops which use the snd-hda-intel driver the microphone often cannot be
activated (in particular, when the system comes out of system installation).

A workaround is the following script alway helps to make the microphone work
(except after a wake-up from suspend-to-disk):
#!/bin/sh
/usr/sbin/alsactl restore
amixer -c 0 sset 'Input Source',0 Line
amixer -c 0 sset 'Input Source',0 Mic

Comments
1. After a bootstrap, the "capture volumn" control of alsamixer always has the
value 0, irrespective of what is stored in /etc/asound.state. The previously
defined value of this control can be re-established with "alsctl restore", but
that does not make the microphone work.

2. Also, when the volume settings are changed with any of the mixers, very
often the microphone will not work any more; but I have not found a
reproducable sequence that provokes the error this way.

3. The microphone can be made work if, afterwords, the sound-input switch is
toggled to "line" and back to "mic".
