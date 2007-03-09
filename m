From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: pcm_multi broken in alsa-lib - no duplex mode with
	jackd
Date: Thu, 8 Mar 2007 19:57:35 -0500
Message-ID: <75b66ecd0703081657w335dfa93uc7514303b7686bc@mail.gmail.com>
References: <45F044D2.1060903@mnet-online.de> <s5hslcfmuk0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hslcfmuk0.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/8/07, Takashi Iwai <tiwai@suse.de> wrote:
> > Many JACK users have successfully used the following patch:
> >
> > http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch
>
> Well, the patch is no real fix.  It's likely a workaround for JACK,
> though.  Someone has to take time to track down this bug more deeply.

I think ALSA should have the same policy as the kernel - that any
change which breaks existing apps must be considered a regression,
even if the change is a bug fix.  So if the real fix can't be found,
the change that broke JACK must be reverted.

What bug was the change that broke JACK supposed to fix?

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
