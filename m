From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Re: dolby digital output
Date: Sun, 17 Feb 2002 18:15:55 +0100
Message-ID: <20020217171555.GA4182@orbital.xs4all.nl>
References: <1013927613.9422.10.camel@samoyed.wuff.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013927613.9422.10.camel@samoyed.wuff.dhs.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Hod McWuff <hod@wuff.dhs.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 17, 2002 at 01:33:32AM -0500, Hod McWuff wrote:

> I'd imagine the first step would be to add an ac3 encoder, and then
> (possibly) the 2->5.1 channel demuxing for stereo streams. This would
> result in the ability to mix dolby digital streams (DVD's) with more
> mundane PCM streams, such as IM or telephony apps.

None of the available open source software AC3 encoders are fast enough to
do realtime 5.1 encoding I think. The main task would be to try and
optimize this. Outputting compressed AC3 frames through alsa is probably
the easiest part (see http://www.alsaplayer.org for ac3play)

Andy

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
