From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Pull request for alsa-plugins
Date: Thu, 04 Sep 2008 11:23:09 +0100
Message-ID: <g9ocud$jjq$2@ger.gmane.org>
References: <20080903191741.GA13536@tango.0pointer.de>
	<s5h63pcnygu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 863D32433F
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 12:25:03 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KbC1O-0008EQ-Rp
	for alsa-devel@alsa-project.org; Thu, 04 Sep 2008 10:25:03 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 10:25:02 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 10:25:02 +0000
In-Reply-To: <s5h63pcnygu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> One of my concerns in the current pulse code is the many use of
> assert().  In many cases, assert() is a wrong choice.  For example,
> checking the return value of malloc in assert() is definitely wrong.
> It should be always checked, and should return an error instead of
> aborting the program.
> 
> Yes, alsa-lib has also many assert() although I removed already many.
> Some of them may be still wrong ones.  Hopefully this can be sorted
> out later.

There has been a rather large thread on this on PA mailing list over the 
last couple days :)

http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/2014

I personally got some stuff wrong, but learned from Lennart's responses.

Certainly I think a lot of the cases where this plugin could have 
previously hit an assert have now been removed. Not sure about the 
malloc asserts() tho'...

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
