From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 22:43:32 +0100
Message-ID: <20060119214332.GZ19398__1336.78903007439$1137707128$gmane$org@stusta.de>
References: <20060119174600.GT19398@stusta.de> <9a8748490601191306q75b101b5g488aee398d420a00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A26C9141
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 22:43:34 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <9a8748490601191306q75b101b5g488aee398d420a00@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2006 at 10:06:47PM +0100, Jesper Juhl wrote:
> On 1/19/06, Adrian Bunk <bunk@stusta.de> wrote:
> [snip]
> > My proposed timeline is:
> [snip]
> > - after the release of 2.6.17 (and before 2.6.18):
> >   remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
> >   known regressions in the ALSA drivers for the same hardware
> 
> May I suggest you also update the "When" part of this entry in
> Documentation/feature-removal-schedule.txt :
> 
> What:   drivers depending on OBSOLETE_OSS_DRIVER
> When:   January 2006
> Why:    OSS drivers with ALSA replacements
> Who:    Adrian Bunk <bunk@stusta.de>

Sure. This will be sent as part of my patch to update the 
OBSOLETE_OSS_DRIVER dependencies.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
