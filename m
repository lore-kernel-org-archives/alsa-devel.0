From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM Rate Plugin
Date: Fri, 12 Apr 2002 09:18:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204120916570.581-100000@pnote.perex-int.cz>
References: <Pine.BSF.4.44.0204120813260.75335-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.BSF.4.44.0204120813260.75335-100000@fest.stud.fee.vutbr.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Apr 2002, Kasparek Tomas wrote:

> On Thu, 11 Apr 2002, Takashi Iwai wrote:
> 
> > Hi Kasparek,
> >
> > > But for native ALSA recoding on frequency other that defined in card ends
> > > with "arecord" saying everything is fine, but created file contains just
> > > header. My driver is requested to capture on some near rate in this case.
> >
> > well, then it's a bug of alsa-lib.
> > could you explain the symptom more precisely?
> 
> I have solved this yet. Original behavior (using "pcm.default") was:
> 
> - using rate supported by card -> mono and stereo capture works
> 
> - using non-standard rate -> just stereo works (that is native for the UDA
>   chip), for Mono "arecod" produces just 44bytes of header.

It should work in both cases. I suspect for a bug in alsa-lib. Can you 
trigger this bug also in snd-dummy driver? Can you send me modified dummy 
driver then?

> Weel, I would like to ask one more question: The chip sipport not only
> 16bit(LE) samples but 18 and 20 bits LE samples too. Would it be hard to
> update ALSA to support these sample sizes? Where should I look for
> informations when trying to get this running?

How are these samples organized? They are stored in 32-bit words or 
something else?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
