From: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 17:38:00 +0200
Message-ID: <20060517153800.GA2894__9194.48197023503$1147880235$gmane$org@localhost>
References: <1147780945.29795.110.camel@johannes> <1147791186.13948.109.camel@mindpipe> <1147791315.983.21.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 25C0D19C
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 17:35:45 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1147791315.983.21.camel@johannes>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 16, 2006 at 04:55:15PM +0200, Johannes Berg wrote:
> On Tue, 2006-05-16 at 10:53 -0400, Lee Revell wrote:
> 
> > Ummm... what problem is this patch fixing?
> 
> The problems that
> (a) kmix, gnome-alsamixer, gnome-volume-control and others can't
>     properly use the playback volume control because it has a range
>     that doesn't start at 0

True if you only use kmix, that via 'ps ax' shows up as something like this:

[ ... ] kmix [kdeinit] -caption KMix -icon kmix -miniicon kmix

But if you - separately and additionally - add the "Sound Mixer"
applet to the KDE kicker (the panel) *plus* make sure you split the
volume control slider for the "Sound Mixer" channel you have a working
volume control .. :)
At least this is how it works here, with 
"Kmix Panel Applet 2.6 (Using KDE 3.5.2)", and on Debian unstable .. 

If I play with these apps there seem to be glitches, so they do not
seem to work "properly". But with a bit of fiddling between what KDE
calls "Sound Mixer" and "Kmix" (both actually seem to be part of the
same application, i.e. kmix) you should have a working volume slider
... 

HTH

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
