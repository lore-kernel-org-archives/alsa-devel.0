From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Oops with snd-ymfpci and ALSA 0.9.3a
Date: Thu, 12 Jun 2003 12:54:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306121253150.1795-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0306121803560.1298-100000@home.aussec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306121803560.1298-100000@home.aussec.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tom burkart <alsa@aussec.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jun 2003, tom burkart wrote:

> Today, Clemens Ladisch wrote:
> 
> > tom burkart wrote:
> > > "aplay something.wav" causes scratchy sounds to be emitted from the
> > Not on my YMF-754 card. Sorry, I don't know what could cause this.
> Ok, how can I help debug this?  (Albeit, slowly, as I am fairly busy)

If I remember correctly, the card is working with OSS drivers? Isn't?
In that case, we might compare PCI registers (lspci -s<DEV> -xxx). 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
