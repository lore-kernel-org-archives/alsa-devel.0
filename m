From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: question about ctl.pulse ?
Date: Wed, 02 Feb 2011 16:09:39 +0000
Message-ID: <iibvk4$345$1@dough.gmane.org>
References: <AANLkTi=1tUeNU7eka42aaGoBRgSNuisocPxwGiDV0k84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id A66C21039F9
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 17:09:55 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PkfHG-0001vs-NG
	for alsa-devel@alsa-project.org; Wed, 02 Feb 2011 17:09:54 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 17:09:54 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 17:09:54 +0100
In-Reply-To: <AANLkTi=1tUeNU7eka42aaGoBRgSNuisocPxwGiDV0k84@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 02/02/11 03:47 did gyre and gimble:
> Refer to
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=doc/README-pulse;h=d5431b481c84d6f6d093a0da0710de699e9cd585;hb=HEAD
> 
> The mixer control plugin also accepts the parameters "source" and "sink" for
> when you need to specify a sink/source combination with different names. If
> you need to do this with PCM:s then specify two PCM:s with different "device".
> 
> 
> Does it mean that the application only get playback controls from
> sink0, sink1 and capture controls from source0, source1, source2

That's what it appears but it still seems to pick the default for the
thing you don't specify...

e.g. if you only give a source, then it will also use the default sink.
and vice versa.

You can tell it not to do that with this:

ctl.sink5 {
    type pulse
    sink "5"
    source "-1"
}

but the source still shows up but manages to some kind of dummy thing.

I guess the plugin code could be tweaked to not have the control if -1
is passed?

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
