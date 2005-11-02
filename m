From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Wed, 02 Nov 2005 11:57:04 -0500
Message-ID: <1130950624.22089.62.camel@mindpipe>
References: <s5h4q6v8h28.wl%tiwai@suse.de>
	 <20051102110045.24792.qmail@web52911.mail.yahoo.com>
	 <s5hwtjr70mp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtjr70mp.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-11-02 at 12:25 +0100, Takashi Iwai wrote:
> At Wed, 2 Nov 2005 11:00:45 +0000 (GMT),
> Chris Rankin wrote:
> > 
> > --- Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > We need to know in which condition the oops occurs.
> > > The stack trace doesn't show the right path.
> > 
> > Like I said, I was unloading every module listed in /proc/modules that started with "snd".
> 
> Which rmmod triggers the oops?

It was not an Oops, the kernel detected a "soft lockup" which IIRC means
some process ran in the kernel for an abnormally long time.  This
usually indicates a bug.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
