From: Rick Mann <rmann@latencyzero.com>
Subject: Unknown PCM cards.pcm.front
Date: Thu, 29 Oct 2015 01:30:39 -0700
Message-ID: <14E6E6A6-54AE-4EB5-8106-791B95650733@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 2721A2654D4
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 09:30:41 +0100 (CET)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 77447206FE
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 04:30:40 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1C68A68010F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 04:30:39 -0400 (EDT)
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

In my custom cape for Beaglebone black, I'm able to play audio reasonably well. But for one situation when my C++ app (which plays via libao) opens an output, this is written to my app's output:

	"ALSA lib pcm.c:2217:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front"

Googling, I found this advice:

	http://alexpb.com/notes/articles/2012/11/14/error-when-playing-audio-on-raspbian-on-a-raspberry-pi/

Which works.

My question is, why do I get it only in this instance? Is it because I might be opening the audio device twice simultaneously? That's about the only thing that might set this situation apart from all the others.

TIA,

-- 
Rick Mann
rmann@latencyzero.com
