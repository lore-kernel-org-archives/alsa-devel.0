From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
	mode]
Date: Mon, 26 Jul 2010 10:26:58 +0100
Message-ID: <i2jkcu$c2o$1@dough.gmane.org>
References: <1280097015.29696.8.camel@localhost.localdomain>	<AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>	<1280107804.29411.1.camel@localhost.localdomain>	<AANLkTimoBu3baCYdDWoBQkATrXhG2R2ExYvWybKy1WK_@mail.gmail.com>	<1280113577.19933.2.camel@localhost.localdomain>
	<AANLkTi=aGfUBy-cF_DoOJVz+XbSc+vUrcKjxtVR6NR=_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A2AE103860
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 11:27:09 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OdJxh-0005dD-BZ
	for alsa-devel@alsa-project.org; Mon, 26 Jul 2010 11:27:05 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 11:27:05 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 11:27:05 +0200
In-Reply-To: <AANLkTi=aGfUBy-cF_DoOJVz+XbSc+vUrcKjxtVR6NR=_@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 26/07/10 04:22 did gyre and gimble:
> But I have another question ,
> 
> did update manager stop pulseaudio server when the update manager want to
> update pulseaudio package ?
> 
> Actually I don't notice yum -y update stop the PA server if it updated
> pulseaudio package (install new pulseaudio and remove old pulseaudio
> package) and restart PA server on Fedora 10

PA is *not* restarted when a new version is installed and I suspect this
does not happen on Fedora either (but I could be wrong).

The reason is that PA is a per-user daemon, not a system service. If
three users were logged in, then each of their PA servers would need to
be killed and restarted but due to console-kit, only the active user
would get access to the devices which could cause enumeration issues etc.

It could maybe be handled better, but doing so would be rather complex.

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
