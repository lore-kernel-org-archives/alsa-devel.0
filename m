From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Re: PCM Rate Plugin
Date: Fri, 12 Apr 2002 08:29:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0204120813260.75335-100000@fest.stud.fee.vutbr.cz>
References: <s5h1ydmky2s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1ydmky2s.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Apr 2002, Takashi Iwai wrote:

> Hi Kasparek,
>
> > But for native ALSA recoding on frequency other that defined in card ends
> > with "arecord" saying everything is fine, but created file contains just
> > header. My driver is requested to capture on some near rate in this case.
>
> well, then it's a bug of alsa-lib.
> could you explain the symptom more precisely?

I have solved this yet. Original behavior (using "pcm.default") was:

- using rate supported by card -> mono and stereo capture works

- using non-standard rate -> just stereo works (that is native for the UDA
  chip), for Mono "arecod" produces just 44bytes of header.

I solved this using own configuration:

pcm.h3600 {
type plug
slave  {
pcm {
    type hw
    card 0
    }
#format "S16_LE"
#channels 2
rate "unchanged"
}
}

I need to specify the "rate" line. Then resampling and mono <-> stereo
transformation works fine. I tried sample format conversion, but it does
work well just with my configuration too. (I tried S|U 16 LE|BE, MU_LAW)

The card is UDA1341TS on H3600 (iPAQ) - native support just for U16_LE,
stereo.

Weel, I would like to ask one more question: The chip sipport not only
16bit(LE) samples but 18 and 20 bits LE samples too. Would it be hard to
update ALSA to support these sample sizes? Where should I look for
informations when trying to get this running?

Bye

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
