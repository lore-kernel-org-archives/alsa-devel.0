From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: aserver, smix
Date: Wed, 26 Feb 2003 20:32:27 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302262031060.1114-100000@pnote.perex-int.cz>
References: <3E5D0647.8040407@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA08883
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2003 20:32:33 +0100
In-Reply-To: <3E5D0647.8040407@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Jozef Kosoru <zyzstar@uid0.sk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Feb 2003, Patrick Shirkey wrote:

> Jozef Kosoru wrote:
> > Hi!
> > 
> > A couple of questions:
> > 
> > I would like to ask what is the main purpose of the aserver. It can run
> > on the same machine as the client only (AFAIK) and it cannot mix multiple
> > client streams into the one device. So I've missed the point of that
> > application -- is there something for which it could be good for?
> > 
> > ALSA plugin documentation mentions the 'smix' plugin. But I cannot find
> > any further information nor the source code in the library for that. Is
> > it something which will be introduced it the future ALSA releases?
> > According the doc it is exactly something I've been looking for a long
> > time; pcm device sharing.
> > 
> 
> This has been discussed many times.
> 
> Currently the only ways to get pcm device sharing, I assume you mean 
> using multiple devices as one virtual device are to write it up in your 
> .asoundrc or use the patch which has been submitted but not applied to 
> jack for this purpose.
> 
> The former is a little tricky to grok but it has been shown to work. The 
> later requires a bit more of a deeper understanding of jack and coding.
> 
> There is info in the online docs. Just click on the link in the asoundrc 
>   section for your device and the file is explained in depth.
> 
> If however you mean hardware mixing (multiple streams at the same time) 
> then it is dependant on the device and the manufacturers supplied tech 
> details.

Note that we have actually the experimental dmix plugin (direct mixing) 
which works for i386 architecture in CVS. The usage is simple:

aplay -Dplug:dmix <filename>

You may pass 'plug:dmix' to any other application.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
