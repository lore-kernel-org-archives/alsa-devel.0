From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: usx2y jack driver
Date: Sat, 25 Sep 2004 15:55:58 +0200
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <200409251555.59384.annabellesgarden@yahoo.de>
References: <200409222228.38243.annabellesgarden@yahoo.de> <32827.192.168.1.5.1096065064.squirrel@192.168.1.5> <1096078552.1407.1.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096078552.1407.1.camel@krustophenia.net>
Content-Disposition: inline
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Am Samstag 25 September 2004 04:15 schrieb Lee Revell:
> On Fri, 2004-09-24 at 18:31, Rui Nuno Capela wrote:
> > I've already worked out this new usx2y jack driver with my US-224 and the
>
> Maybe I am missing something.  Why does this device need a specific jack
> driver, as opposed to using the ALSA driver?  Wouldn't it be better to
> improve the ALSA driver so that it can be used with jack?
>
Its usb's unableness to atomically handle power of 2 period sized data chuncs,
what led to: 
This usx2y-alsa-jack driver pair uses a hardware dependant alsa-device for 
mmaped pcm transport.
Advantage achieved:
	The usb_hcd places reads/writes pcm data into dma-memory.
	That memory is 	mmaped by jack's usx2y driver.
	Jack's usx2y driver is the first/last to read/write pcm data.
	Read/write is a combination of power of 2 period shaping and
	float/int conversation.
	Compared to mainline alsa/jack we leave out power of 2 period shaping inside
	snd-usb-* which needs memcpy() and additional buffers.
	As a side effect possible unwanted pcm-data coruption resulting of
	plain alsa's snd-usb-usx2y period shaping scheme falls away.
	Result is sane jack operation at buffering schemes down to 128frames,
	2 periods.
	plain usx2y alsa mode is able to achieve 64frames, 4periods, but only at the
	cost of easier triggered i.e. aeolus xruns (128 or 256frames,
	2periods works but is useless cause of crackling).

New functionality would possibly be better integrated into mainlines at more 
apropriate places.
Target could be: jack mmaping power of 2 period sized float-pcm buffers and 
letting alsa (snd-usb-lib - alsa-lib - plugin) do power of 2 period shaping 
and float/int conversation.

erm, but I'd rather make some sounds with this stuff before i dig into that 
deeper. And there is still that ohci issue.

Best,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
