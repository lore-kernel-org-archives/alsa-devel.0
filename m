From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 5/8] add MIDI interface
Date: Mon, 03 Jun 2013 13:18:37 +0200
Message-ID: <51AC7B8D.5070806@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
	<1370102158-24389-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: o-takashi@sakamocchi.jp
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

o-takashi@sakamocchi.jp wrote:
> + * [MIDI stream side]
> + *  1.When no stream in both direction is started, start stream with 48000
> + *  2.When stream in opposite direction is started, start stream with the same
> + *    sampling rate.
> + *  3.When stream in the same direction has PCM stream and request to stop MIDI
> + *    stream, don't stop stream itself.
> + * [PCM stream side]
> + *  1.When stream in the both direction is started and has no PCM stream, stop
> + *    the stream because it include just MIDI stream. Then restart it with
> + *    requested sampling rate by PCM component.
> + *  2.When MIDI stream is going to be closed but PCM stream is still running,
> + *    the stream is kept to be running.
> + */

These rules will become even more complex when handling playback/capture
stream synchronization.

I think it would be a better idea to add some reference counting scheme
for determining when an AMDTP stream needs to be running.


Regards,
Clemens

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
