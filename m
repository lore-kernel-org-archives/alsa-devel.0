From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: [conf patch] modem's pcm "two device" config [was:
 Re: Mo' better modem support]
Date: Tue, 13 Sep 2005 20:27:17 +0300
Message-ID: <20050913172717.GC31269@sashak.softier1.local>
References: <s5h8xyauxxr.wl%tiwai@suse.de>
 <20050907160343.GA3375@sashak.softier1.local> <20050912002746.GA31233@tecr>
 <s5hzmqih8q2.wl%tiwai@suse.de> <s5hzmqifa6e.wl%tiwai@suse.de>
 <20050912221018.GA19713@tecr> <s5hmzmhfh0o.wl%tiwai@suse.de>
 <20050913143520.GA31269@sashak.softier1.local> <s5h64t5f89o.wl%tiwai@suse.de>
 <20050913153647.GB31269@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050913153647.GB31269@sashak.softier1.local>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 18:36 Tue 13 Sep     , Sasha Khapyorsky wrote:
> 
> What I think happens here is that non-zero index is lost somewhere:
> 
>  # amixer -c 1 controls 
>  numid=1,iface=MIXER,name='Off-hook Switch'
> 
> No 'index' is shown there. I'll dig a little.

I've used outdated version for comparing where 'Off-hook' control was
done in intel8x0m.c with index '0'. With recent version all is as
expected. Sorry about noise.

Sasha.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
