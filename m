From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 09:56:46 +0100
Message-ID: <20041111085646.GB17034@rhlx01.fht-esslingen.de>
References: <20041110235502.6C8211D2B2D@sc8-sf-uberspam1.sourceforge.net>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20041110235502.6C8211D2B2D@sc8-sf-uberspam1.sourceforge.net>
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

Hi,

On Wed, Nov 10, 2004 at 03:54:01PM -0800, alsa-devel-request@lists.sourceforge.net wrote:
> Message: 9
> Subject: Re: [Alsa-devel] The ALSA Situation
> From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> To: Linus Torvalds <torvalds@osdl.org>
> Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>,
>         alsa-devel@lists.sourceforge.net
> Organization: 
> Date: 10 Nov 2004 15:53:08 -0800
> 
> If the end of the sound being played has an envelope that gradually[*]
> decreases to zero and the last sample of the last buffer is zero, the
> soundcard should not pop when the stream is closed. Unless there are
> hardware issues impossible to solve through software I'd call that a
> bug. 
> 
> If the samples being played end abruptly (ie: the last sample of the
> last buffer to be played is non-zero) then there will be a pop
> independently of whether we chain apps or not. It is highly unlikely
> that the next app will start playing a sound that happens to have the
> same starting DC level as the previous one ended with. Jump in DC level
> == pop. 

Which is why this popping would probably be best solved at ALSA internal
level (not driver level, either; the driver should just make sure that
its soundcard handling doesn't interfere with ALSAs intentions).
I.e. when opening/closing a stream, make sure it fades in/out without
strongly disturbing the currently played (or not played in case of
silence level) state.
And allow this "smoothing" to be turned off for high-end audio users,
of course...

In my azt3328 driver, I went through great pains to try to avoid popping
(mostly successful), but I guess some of that work is actually not necessary
any more once stream popping issues get handled at ALSA level.
(BTW: does the other operating system take any measures against popping?)

Andreas Mohr


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
