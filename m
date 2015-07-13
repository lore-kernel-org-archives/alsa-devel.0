From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 32/37] ALSA:
 firewire-motu: add stream functionality
Date: Mon, 13 Jul 2015 20:39:38 +0930
Message-ID: <20150713110938.GC32641@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-33-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 9438B2604D6
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:09:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-33-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 11, 2015 at 11:12:43PM +0900, Takashi Sakamoto wrote:
> Several clock sources are available, while there're no differences about
> packet transmission among clock sources. The value of SYT field in
> transferred packets is always zero. Thus, streams in both direction
> don't build synchronization.

Perhaps I've misinterpreted what's meant here, but the above doesn't seem
correct to me.  MOTU devices to synchronise tx streams with rx streams. 
They use the timestamps in the rx packets to synchronise the tx packets to
the device's audio clock as I outlined in an earlier message.  This of
course makes the tx side dependent on the rx side, something which might not
be allowed for in this version of the driver.

> The number of data chunks for PCM samples is decided according to current
> sampling rate, optical mode for digital input/output interfaces. For PCM
> functionality, the number of data blocks is cached in device instance.

As far as I can tell there is no allowance in this driver for channel
naming.  I do not know whether the ALSA API allows for such things, but with
multichannel interfaces with different types of I/O it is very helpful to
the user that there is some indication as to what each stream does.  Can you
comment on this?

Another thing which has proven very useful for FFADO users is to have the
first two output channels mapped to something is is generally useful, rather
than simply ordering the channels in the way defined by the data format of
the packets.  Exactly what this looks like depends on the interface and the
precise mix of channels provided.  For example, sometimes it's the headphone
outputs, other times it's the designated "Main" outputs.  Again, I'd be
interested in your thoughts about this and how something along these lines
might be done using this driver.  Would it come down to the writing of a
suitable .asoundrc file?

Regards
  jonathan
