From: Robert Vetter <rv@robertvetter.com>
Subject: Re: RME Digi 96 Control
Date: Tue, 8 Apr 2003 18:59:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304081854.41438.rv@robertvetter.com>
References: <200304041310.21272.rv@robertvetter.com> <s5hhe99q739.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe99q739.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello Takashi

On Tuesday 08 April 2003 18:36, you wrote:
> i'd love to put this stuff into alsa-tools tree once if the code
> becomes stable.

That would be great.

> a few notes:
>
> - so far, i got an error when i start this problem without rme96
>   card. it seems that the check of the existence of the rme96 driver is
>   broken.  also, it would be better to check the return value of
>   snd_ctl_elem_read(), etc.

This is a bug. I have to fix it.

> - usual doc files like README, COPYRIGHT?

... would be nice, I know. When I find a free minute I'll do it.

> - auto-toolize?  (i can do it if necessary.)

What's the easiest way to make it? I have never done it before.

Robert



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
