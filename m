From: dave murray-rust <hdsp@mo-seph.com>
Subject: HDSP OSS Emulation
Date: Fri, 14 Jan 2005 11:40:34 +0000
Message-ID: <200501141140.34929.hdsp@mo-seph.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

First of all, many thanks to all for getting the HDSP working on
linux, it's looking lovely.

I'm having a problem with the OSS emulation, however, in that it
outputs on all 18 channels simultaneously. I read something about this
on the list archives [1], and I was wondering if any progress has been
made, or if there are any workarounds? The application I'm running is
based on the (rather outdated) xaudio library, and responds badly to
'aoss'.

Any thoughs?

Cheers,
dave

[1]
(Question from Ed Wildgoose, response from Thomas Charbonnel, May
2004)

> 4) Why does the OSS emulation write to all (16)  channels when an app
> opens it in 2 channel mode?  It's very easy to do something really silly
>  as a result (I got a rather nasty burning smell from my expensive
> speakers after inadvertently putting a lot of clipped signal through
> them at high power...)  Is this an OSS issue, or just the way this
> driver works?  (I don't have any other multichannel cards to compare
> against!)

I'm aware of this problem, but still have to track it down. I guess it's
related to the fact that the card can only be opened using all available
channels. I don't know if oss emulation uses the plughw facility, but
there must be something similar because non-interleaved streams are
handled properly, there just lacks something to deal with the number of
channel.
-- 
He who laughs last thinks slowest.
  - forwarded email




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
