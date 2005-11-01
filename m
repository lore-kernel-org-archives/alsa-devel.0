From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Tue, 01 Nov 2005 18:22:56 -0500
Message-ID: <1130887377.22089.22.camel@mindpipe>
References: <20051101222359.64797.qmail@web52906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051101222359.64797.qmail@web52906.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-11-01 at 22:23 +0000, Chris Rankin wrote:
> --- Takashi Iwai <tiwai@suse.de> wrote:
> > Anyway, try the patch below.  We need a better clean up later.
> 
> The MIDI files play now, but this happened when I tried to unload the modules using the following
> command:
> 
> # awk '{print \$1}' < /proc/modules | grep ^snd | xargs /sbin/rmmod
> 
> BUG: soft lockup detected on CPU#0!
> 
> Pid: 4057, comm:             asfxload

You unloaded the modules while asfxload was loading a soundfont?

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
