From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [RFC v2][PATCH 00/11] ALSA: fireface: new driver
 for RME Fireface series
Date: Wed, 23 Dec 2015 01:10:41 +1030
Message-ID: <20151222144041.GB31312@marvin.atrad.com.au>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151221041439.GC13668@marvin.atrad.com.au>
 <5677F7F6.1050901@sakamocchi.jp>
 <20151222064535.GZ11792@marvin.atrad.com.au>
 <56792BDB.3060801@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id AA807260483
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 15:40:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56792BDB.3060801@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2015 at 07:54:19PM +0900, Takashi Sakamoto wrote:
> Once the device is unmute, then it keeps the state regardless of
> starting/stopping streams. If the vendor uses the unmute state to avoid
> any noises at starting packet streaming, the device should automatically
> be muted when starting streaming or after stopping streaming.

The vendor unmutes this register when streaming is started for the first
time after device initialisation.  This is possibly due to noise suppression
during the initial device setup although I have not verified this
electrically.  In my view we should do the same since this is the way the
device is used (and therefore supported) on other operating systems.  If we
deviate from the way the vendor drives the interface we could introduce
subtle side effects for no good reason.

> I realize it means that unmute/mute are not related to streaming
> functionality. Therefore, no reasons to implement it in streaming driver.

We may have to agree to disagree on this point.  Where possible we should,
imho, drive the hardware according to the vendor's procedures.

> >> I'd like to drop the code to send write transactions to the address, and
> >> leave the decision to userspace. ...
> :
> Please read fireface-proc.c or snd_ff_stream_get_clock() in
> fireface-stream.c, then describe your opinion about the issue.

snd_ff_stream_get_clock() is exclusively about identifying the clock source
and rate.  Some of this information is available in the read-only status
registers starting at 0x801c0000 as you have found.  However, deducing the
rate from bits returned by a single quadlet read of 0x801c0004 is
undocumented and in any case will not be accurate for some sync modes and
clock sources.  This means that some configuration needs persistent storage
and the kernel driver is the logical place for this.  As an aside, the
status register content changes depending on the block read origin and
request size.

fireface-proc.c provides userspace with access to the status register, with
the same access caveats as for snd_ff_stream_get_clock().

At this point I am inclined to just wait to see what lands and fix up the
usability and interfacing issues later.

Regards
  jonathan
