From: Mark Knecht <markknecht@comcast.net>
Subject: Re: ALSA 1.0.0rc1 released
Date: Tue, 02 Dec 2003 20:12:52 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070424772.22549.17.camel@Wizard.knechthome.com>
References: <s5hu14kabjn.wl@alsa2.suse.de>
	 <1070312195.3552.14.camel@Wizard.knechthome.com>
	 <3FCCD6FF.30605@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FCCD6FF.30605@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: derosier@pianodisc.com
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-12-02 at 10:16, Steve deRosier wrote:
> We went ahead and added code to our alsa client software to cleanly 
> return to a PCM value of 0 and then stuffed a full buffer worth of 0s 
> into the buffer before closeing the PCM in order to solve our pop 
> problem.  I'm not sure how the OSS emulation stuff works since we don't 
> use it, but maybe it could use this same treatment?  I'm assuming we 
> don't want to change OSS client programs to fix it, so that would leave 
> something in the emulation layer that should be changed.  Perhaps OSS 
> automagically does this cleanup?  Mark, have you tried using the real 
> OSS?  Do the pops happen with OSS?

No, I haven't tried real OSS. I'm fairly new to Linux audio and have
never used anything other than Alsa in all it's glory. I don't know how
OSS would be installed under Gentoo. I don't see any ebuilds for it. I
presume it will work if I build it from source by hand, but that does
sound like a lot of work.

In my current case the pops only happen with OSS emulation under Alsa.
All files that create pops using OSS emulation work perfectly if I use
any native Alsa app to play them, so I really don't think it's the
source material itself. 

I wish I didn't have to use OSS at all. Has anyone accomplished getting
all types of web-based multi-media to work just using Alsa? Any
mime.type files to lead the way?

- Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
