From: Zinx Verituse <zinx@epicsol.org>
Subject: Re: patch, and other via82xx (VT8235) capture problems
Date: Mon, 27 Oct 2003 15:35:49 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031027213549.GA22457@bliss>
References: <20031023044843.GA19701@bliss> <s5hznfr99zs.wl@alsa2.suse.de> <20031024010502.GA22833@bliss> <s5h8yna93qz.wl@alsa2.suse.de> <20031024205918.GA29951@bliss> <20031025143159.GA1176@bliss> <s5hllr76jz2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hllr76jz2.wl@alsa2.suse.de>
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

On Mon, Oct 27, 2003 at 11:41:37AM +0100, Takashi Iwai wrote:
> At Sat, 25 Oct 2003 09:31:59 -0500,
> Zinx Verituse wrote:
> >
[snip]
> > 
> > I have more to report on this issue:
> > When I was recording with 'Line' selected as the 'Input Source',
> > 'Mic' was the selected recording device, and 'Line' was completely
> > silent.  Also, I have noticed that if I'm playing something on
> > hw:0,0, then hw:0,1 fails like recording does.  However, if I try
> > to play two things to hw:0,0, it works.  And if I try to play
> > something to hw:0,1 while hw:0,0 is closed, it also works.
> 
> well, playing hw:0,0 and hw:0,1 is different from capture.
> hw:0,0 is the multi-play device (DXS channels) while hw:0,1 is the
> multi-channel play device for 5.1 outputs.  and you cannot access to
> both devices at the same time, anyway.
> 

Might I suggest that it gives device or resource busy, or blocks on
open, then? :)  Right now, it's pretending everything is fine, until
you try to actually play something, then it just sits there doing
nothing.

-- 
Zinx Verituse


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
