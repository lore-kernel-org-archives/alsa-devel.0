From: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Subject: Re: asoundrc problem
Date: Tue, 4 Feb 2003 13:56:31 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302041351310.16171-100000@rzstud2.stud.uni-karlsruhe.de>
References: <s5hhebkgre8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhebkgre8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Feb 2003, Takashi Iwai wrote:

>
> well, this might be because you specfied 8 channels instead of 10.
> the hardware supports only 10 channels natively.
>
> could you check whether 20 (10+10) channels work?

One interesting thing is, that it works with -Ddefault
There I can specify as many channels(1-10) as I want and it works.
With -Dhw:0,0 -c10 again there comes
set_params:792: Channels count non available

Can I find out what the alias default stands for?

I also tried to extend the multi slave to 2x10 Channels, but that doesn't
work either.

Oli



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
