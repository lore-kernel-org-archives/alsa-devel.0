From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: issues with usb-audio and maudio quattro
Date: Sun, 8 Dec 2013 01:47:19 +1100 (EST)
Message-ID: <63609.101.0.71.24.1386427639.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id AFFB3261981
 for <alsa-devel@alsa-project.org>; Sat,  7 Dec 2013 15:47:16 +0100 (CET)
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

Hi,

It seems that some changes were made to the usb-audio driver over the
years that have resulted in partially broken  behaviour with maudio
quattro.

We have run some tests on two different devices with different machines
and found the following items:

1: There are no longer three pcm devices - this breaks previously working
asoundrc files
2: pcm0 and pcm1 have different behaviours - this results in audio input
working for pcm0 but white noise in pcm1 (probably due to endianess le vs
be)
3: We can record 4 tracks with arecord. Tracks 1/2 have audio and track
3/4 have white noise
4: We can no longer run 4 playback tracks in JACK2 as it complains about
the ports not matching (this might be a seperate issue with JACK2 and
route/plug configs for multichannel devices but that would probably affect
the delta 10/10, RME Hammerfall or other multichannel devices too.)

jackd: ../common/JackGraphManager.cpp:44: void
Jack::JackGraphManager::AssertPort(jack_port_id_t): Assertion `port_index
< fPortMax' failed.


So the main question is who made the decision to drop/consolidate the
third pcm and break previously working asoundrc files?

There must be a good reason in which case maybe we can get things working
again relatively easily?



Cheers

--
Patrick Shirkey
Boost Hardware Ltd
