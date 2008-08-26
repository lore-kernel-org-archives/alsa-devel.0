From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Issue with Alsa and PulseAudio
Date: Tue, 26 Aug 2008 16:39:25 +0100
Message-ID: <48B423AD.4090601@colin.guthr.ie>
References: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>	<g9171a$jko$1@ger.gmane.org>
	<s5hd4jvlrlr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 904D524150
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 17:39:38 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KY0dt-0008Qe-Sz
	for alsa-devel@alsa-project.org; Tue, 26 Aug 2008 15:39:38 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 15:39:37 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 15:39:37 +0000
In-Reply-To: <s5hd4jvlrlr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ash <hashbrown100@hotmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> There is no alsa-lib code that returns -EPERM by itself.
> Usually this error comes from the ioctl, but in this case, it must be
> from pulse plugin.  And, pcm_pulse.c contains no EPERM, it must come
> from the pulseaudio itself.
> 
> So, my rough guess is that PA is running by a different user
> (e.g. root) that doesn't allow you to connect it.

Interesting analysis, thanks Takashi.

Ash, if you want me to help with debugging, I am usually on 
#mandriva-cooker and #pulseaudio on IRC (nick coling).

If I don't answer after a ping it means I'm not there!

> Of course, first I'd do is to upgrade alsa-lib and alsa-plugins.
> 1.0.16 is fairly old.

Ash, if you think this would help, I can backport these two packages on 
Mandriva for the 2008.1 version but the driver will have to remain at 
1.0.16. (actually a current backport would get the 1.0.18rc2's).

And Takashi, do you age faster than most humans? 1.0.17 only went final 
few weeks ago!!! (although I accept there have been several good 
bugfixes since!!)


Cheers

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
