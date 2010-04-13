From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: ALSA application programming: route audio from one
	PCM to another
Date: Tue, 13 Apr 2010 17:23:03 +0100
Message-ID: <hq25p7$8kd$1@dough.gmane.org>
References: <4BC48C74.5010102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id C34C5248D3
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 18:23:16 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O1itO-0002nz-WE
	for alsa-devel@alsa-project.org; Tue, 13 Apr 2010 18:23:15 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 18:23:14 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 18:23:14 +0200
In-Reply-To: <4BC48C74.5010102@gmail.com>
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

'Twas brillig, and Stefan Schoenleitner at 13/04/10 16:23 did gyre and
gimble:
> Hi,
> 
> I finally managed to write an ALSA I/O plugin that does what I want.
> The plugin supports both playback and capture.
> 
> Now I would like to write a simple audio application that takes audio
> samples
> 
> 	* from the microphone and plays it back on my plugin
> and
> 	* from the plugin (capture) and plays it back on the speakers
> 

This sounds like something that would be more appropriate for jack
http://jackaudio.org/

> Hence as long as the application is running, it should do the above.
> 
> * Is there a special ALSA way to route audio from one PCM to another ?
> 
> * If not, I suppose it would just work if I open the plugin PCM and the
> hw PCM at the same time and copy audio frames between them ?

Dealing with this can be quite complex, especially if the pcms are
clocked of different sources, you have to deal with a degree of
resampling to ensure that clock skew doesn't get out of control.

The module-loopback plugin in PulseAudio does a similar thing (routes
audio from a source to a sink) and as such has to deal with these clock
skew problems.

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
