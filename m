From: Simon Kirby <sim@netnation.com>
Subject: Re: GUS anti-noise hack
Date: Tue, 30 Apr 2002 09:32:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <aaulht$4a6$2@main.gmane.org>
References: <20020430182134.C22103@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from oof.localnet (h24-78-175-24.vn.shawcable.net [24.78.175.24])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA08562
	for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2002 18:31:46 +0200
Content-Disposition: inline
In-Reply-To: <20020430182134.C22103@ghost.cybernet.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Karel Kulhavy <clock@ghost.cybernet.cz>
Cc: linux-kernel@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 30, 2002 at 06:21:34PM +0200, Karel Kulhavy wrote:

> The linux GUS driver sometimes begins to make a white noise in right or left
> channel. It is very annoying because it is very remarkable and is there for
> every mp3 you listen to.
> 
> I have developped a hack how to get rid of it when it happens.
> 
> a:
> 
> cat /dev/urandom > /dev/dsp and wait for an audible chirp in the bad
> channel. Then try to play some mp3. If noise persists, goto a;
> 
> It has worked for me already for two times and I spared myself two reboots :)

Is this the ALSA driver?  I may be having the same problem.

With the OSS driver it mostly works, but changing mixer settings during
lpayback causes stereo timing skewing, which is extremely noticeable with
headphones even after changing the volume two or three times.  (The
music sounds like it's moving to one side.)

With the ALSA driver, about 25% of the time after starting MP3 playback,
the right channel (right channel only) will start playing an incorrect
part of the GUS memory and sound like old data or uninitialized memory. 
Stopping and starting playback usually fixes this (stopping and starting
will eventually always fix it).  Quite annoying. :)

(Also, multiple open in the GUS driver is completely broken and freezes
my machine right now.  A few years back it used to work properly.)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
