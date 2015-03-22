From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] firewire mixer interface -- was Re:
 [PATCH 11/11] ALSA: digi00x: apply double-oh-three algorism to multiplex
 PCM samples
Date: Sun, 22 Mar 2015 16:41:02 +1030
Message-ID: <20150322061101.GB31970@marvin.atrad.com.au>
References: <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
 <550B51BC.80506@sakamocchi.jp> <550C0CFC.4060404@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5D02604CF
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 07:11:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <550C0CFC.4060404@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 20, 2015 at 01:05:16PM +0100, Robin Gareus wrote:
> I was under the impression that the whole point of moving 1394 audio into
> the kernel was to allow seamless integration with the rest of ALSA.

Speaking as a FFADO developer, the primary reason for pushing FFADO's audio
streaming code into the kernel is for performance and reliability reasons:
it is difficult to maintain the necessary timing when running as a userspace
client of the juju ABI.  Being in kernel brings advantages in this respect. 
The mixer side of things is competely orthogonal to the audio streaming
system in FFADO and was therefore peripheral to this.  As a result the
movement of device control into ALSA wasn't really discussed in great
detail: regardless of whether a kernel or user-space streaming engine is
used, the device control component of FFADO (ffado-mixer) will continue to
be functional.

At least in the first instance the thought was to concentrate on getting the
streaming code into the kernel since that would resolve a vast majority of
performance issues that FFADO faces.  Furthermore, kernel streaming is the
only manditory component needed to allow firewire interfaces to be usable
from "ALSA" applications (presently a program must support JACK to make use
of devices supported by FFADO).  For many users of these interfaces, the
fact that they might have to use something other than alsamixer to control
the interface is completely irrelevant.

The idea was that once in-kernel streaming was operational the longer term
mixer situation could then be looked at if it made sense to change it. 
Whether things work out like this remains to be seen.

Regards
  jonathan
