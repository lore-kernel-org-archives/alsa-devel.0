From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: [conf patch] modem's pcm "two device" config [was:
 Re: Mo' better modem support]
Date: Tue, 13 Sep 2005 18:36:47 +0300
Message-ID: <20050913153647.GB31269@sashak.softier1.local>
References: <20050905232951.GG20428@sashak.softier1.local>
 <s5h8xyauxxr.wl%tiwai@suse.de> <20050907160343.GA3375@sashak.softier1.local>
 <20050912002746.GA31233@tecr> <s5hzmqih8q2.wl%tiwai@suse.de>
 <s5hzmqifa6e.wl%tiwai@suse.de> <20050912221018.GA19713@tecr>
 <s5hmzmhfh0o.wl%tiwai@suse.de> <20050913143520.GA31269@sashak.softier1.local>
 <s5h64t5f89o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h64t5f89o.wl%tiwai@suse.de>
Content-disposition: inline
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 14:43 Tue 13 Sep     , Takashi Iwai wrote:
> 
> Do you mean that the modem with hooks works even without your changes
> of ac97_* in the driver?

Yes and with new changes as well.

> It would be ridiculous.  Possibly, the
> modem codec was found in ac97.num=0?

No, ac97.num = 1 (it is "standard" ICH3 with dual audio+modem ac97):

 # ls /proc/asound/Modem/codec97#0/
 mc97#1-1  mc97#1-1+regs

(opposite ac97_read/write would not work, primary/secondary codec access
is addressed by ac97.num)

> What I mentioned above is that pcm hook finds the correct control
> handle regardless of the card index.  But each control element is
> not.  A non-zero index of each hooked control element must be
> defined explicitly in hook configuration.  Ditto for device and
> subdevice.

I understand your arguments, and this part seems ok.

What I think happens here is that non-zero index is lost somewhere:

 # amixer -c 1 controls 
 numid=1,iface=MIXER,name='Off-hook Switch'

No 'index' is shown there. I'll dig a little.

Sasha.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
