From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: quake3 and alsa trouble: resampler probably doesn't
 work properly?
Date: Mon, 5 Jan 2004 10:54:34 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401051053470.1862@pnote.perex-int.cz>
References: <3FF85629.5070507@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FF85629.5070507@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 4 Jan 2004, Prakash K. Cheemplavam wrote:

> Hi all,
> 
> I am using nforce2 with intel8x0 compiled into 2.6.1-rc1-mm1 based kernel.
> 
> if you just start quake3 then you will have no sound. If you apply the 
> famous cat "bla direct" > /bla/pcm/bla (and the other disable for 
> capture), then sound reappears. Ok. But as soon as I load a map (except 
> the very first one) quake will "soft freeze" ie you will hear a portion 
> of sound getting repeated and quake3 as such seems to be frozen. But you 
> can simple kill it and the rest of the system is not affected. I then 
> compiled debug into alsa and got this assert error in the "soft freeze":

Can you try the latest kernel patch?

ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-12-30.patch.gz

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
