From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Envy24 -PSDIN(3) -bug1472 fix
Date: Wed, 8 Feb 2006 20:02:18 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0602082000220.9386@tm8103.perex-int.cz>
References: <200602030928.18467.gineera@aspect135.co.uk>
 <200602052115.52601.gineera@aspect135.co.uk> <200602081532.17040.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602081532.17040.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Feb 2006, Alan Horstmann wrote:

> On Sunday 05 February 2006 21:15, I wrote:
> > > Re bug1472, Distortion noise:
> 
> > The attached patch does this in ice1712.c;  will this fix be able to make
> > it into 1.0.11 final?  This is the last of my list of '6fire bugs/funnies so
> > it would be good if they were all together in one release.
> >
> > bug1472-dmx6fire-limit-to-6ADCs.patch
> >
> > Summary: Disable unused ADCs & DACs on DMX6fire
> >
> > Change the value written to hardware configuration register of envy24 chip
> > in the case of Terratec DMX6fire to restrict the active ADCs & DACs to 6.
> >
> > Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>
> 
> As noted on bug-track, slight typo in patch; corrected version 3 attached here 
> also.

Already in CVS in slightly modified form:

ice1712.c:
revision 1.78
date: 2006/02/08 07:40:33;  author: perex;  state: Exp;  lines: +14 -2
Summary: ice1712 - disable unused ADCs & DACs on DMX6fire

You can enable DXR via module parameter 'dxr_enable'.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
