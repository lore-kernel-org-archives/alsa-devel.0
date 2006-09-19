From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: is there ioctl compat issues on x86_64?
Date: Tue, 19 Sep 2006 11:38:20 +0200
Message-ID: <m2odtc19ir.fsf@vador.mandriva.com>
References: <m2bqpjtw67.fsf@vador.mandriva.com> <s5hpsdsw6y5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsdsw6y5.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	19 Sep 2006 11:18:10 +0200")
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

Takashi Iwai <tiwai@suse.de> writes:

> > I just found out that running alsamixer from alsa-utils-1.0.12
> > with a 2.6.17 kernel with alsa-kernel-1.0.12 results in the
> > following kernel messages: ioctl32(alsamixer:5014): Unknown cmd
> > fd(3) cmd(c008551a){00} arg(08075f70) on /dev/snd/controlC0
> (snip)
> 
> Fixed on the current HG tree (not in rc2 though).
> 
> Thanks.

thanks you for fixing it

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
