From: Richi Plana <richip@richip.dhs.org>
Subject: Re: Frequency Problems with 0d8c:0201 and	snd-usb-audio
Date: Thu, 16 Nov 2006 11:29:05 -0700
Message-ID: <1163701745.3406.47.camel@richip.dhs.org>
References: <1163613613.3406.14.camel@richip.dhs.org>
	<1163668222.21027.276016817@webmail.messagingengine.com>
	<1163696903.3406.29.camel@richip.dhs.org>
	<1163697994.10962.276090935@webmail.messagingengine.com>
	<1163701408.3406.41.camel@richip.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <1163701408.3406.41.camel@richip.dhs.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-11-16 at 11:23 -0700, Richi Plana wrote:

> As objectively as I can describe it: the audio played at 48 kHz seems to
> be coming out at the right speed, but the sound itself is played at a
> higher pitch. It's as if each sample block is sent and received at the
> correct interval, but actual data from the block is being played back at
> a higher rate. It feels like either the DAC is playing at a higher rate
> but each block comes at the correct intervals ... or the data isn't
> getting to the processor fast enough so it tries to play the bursts as
> quickly as it can.

Oh, and if it helps any: the mixer response seems pretty sluggish. When
I use the sliders on gnome-volume-control, it takes a while for the
sliders to respond to each event I send it. I don't know if that's usual
for "USB" audio devices, though.
--

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
