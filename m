From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Fri, 19 Oct 2012 17:28:23 +0200
Message-ID: <1350660503.5494.15.camel@didier-laptop>
References: <1350652166.5549.8.camel@didier-laptop>
 <5081539E.40705@gmail.com> <1350654327.8310.4.camel@didier-laptop>
 <50815B51.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E15A265B7B
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 17:28:29 +0200 (CEST)
In-Reply-To: <50815B51.3090402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Daniel,

I noticed something strange on the screenshots. AudioMIDISetup says the
Reloop Play is a 24bit device (and indeed this is what is advertised on
the Reloop page http://www.reloop.com/reloop-play). However, when I
inspect the proposed audio formats through Javasound the only format
proposed are:

      Format: PCM_SIGNED unknown sample rate, 16 bit, mono, 2
bytes/frame, little-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, mono, 2
bytes/frame, big-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, stereo, 4
bytes/frame, little-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, stereo, 4
bytes/frame, big-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, 3 channels, 6
bytes/frame, little-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, 3 channels, 6
bytes/frame, big-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, 4 channels, 8
bytes/frame, little-endian
      Format: PCM_SIGNED unknown sample rate, 16 bit, 4 channels, 8
bytes/frame, big-endian
      Format: PCM_SIGNED unknown sample rate, 8 bit, mono, 1
bytes/frame, 
      Format: PCM_UNSIGNED unknown sample rate, 8 bit, mono, 1
bytes/frame, 
      Format: PCM_SIGNED unknown sample rate, 8 bit, stereo, 2
bytes/frame, 
      Format: PCM_UNSIGNED unknown sample rate, 8 bit, stereo, 2
bytes/frame, 
      Format: PCM_SIGNED unknown sample rate, 8 bit, 3 channels, 3
bytes/frame, 
      Format: PCM_UNSIGNED unknown sample rate, 8 bit, 3 channels, 3
bytes/frame, 
      Format: PCM_SIGNED unknown sample rate, 8 bit, 4 channels, 4
bytes/frame, 
      Format: PCM_UNSIGNED unknown sample rate, 8 bit, 4 channels, 4
bytes/frame, 

Is it possible that ALSA does not correctly see that it is a 24-bit
soundcard ?

Didier.
