From: Colin Fletcher <colin.m.fletcher@googlemail.com>
Subject: Can't connect to MIDI output of Edirol UA-1000
Date: Tue, 18 Sep 2012 15:05:10 +0100
Message-ID: <50587F96.8080005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0682650B0
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 16:03:52 +0200 (CEST)
Received: by weyx10 with SMTP id x10so4289963wey.38
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 07:03:51 -0700 (PDT)
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


Hello all,

I hope this is the right place to report this and ask for help: if
not, I'd be glad of a pointers to any more appropriate forum.

I've just recently noticed that connections to the MIDI output of my
Edirol UA-1000 fail when using the snd_ua101 driver in recent kernels.

Although the port is listed, connections to it fail from all the
software I've tried: qjackctl, a2jmidid and aconnect all fail to connect.

aconnect simply reports "Connection failed (Input/output error)";
a2jmidid -e says "ERROR: a2j_port_create: snd_seq_connect_to() for
20:0 failed with error -5"; and qjackctl reports no error but refuses
to make the connection.

I've observed the problem in stable kernels 3.0.39 and 3.4.11; it
works as expected when booted into a 2.6.32 kernel, where the
snd_usb_audio driver is used for the UA-1000. Other USB MIDI devices
appear to work fine with the newer kernels.

Incidentally, I also noticed that the 'Control' MIDI in & out of the
UA-1000 no longer appear when using snd_ua101, but I don't think this
is related, since changing the values of midi_ep.out_cables and
midi_ep.in_cables to 3 in the ua101_probe() function in
sound/usb/misc/ua101.c brings the control in & out back, but I'm still
unable to connect the outputs.

Any help, suggestions, patches or requests for more details gratefully
received!

Thank you,

Colin Fletcher.
