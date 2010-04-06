From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Help! Need to switch between normal speaker and BT
	headset dynamically
Date: Tue, 06 Apr 2010 09:19:16 +0100
Message-ID: <hpeqq4$skf$1@dough.gmane.org>
References: <x2vc731536d1004040850gedb4eee1rccf18941cf25aade@mail.gmail.com>	<s2u604760771004041236k317d9430vf0ea551f17c6374e@mail.gmail.com>
	<s2kc731536d1004052206t279dd76au1804bd0d8339cec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B0FB24458
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 10:19:28 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nz40M-0000xx-KC
	for alsa-devel@alsa-project.org; Tue, 06 Apr 2010 10:19:26 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 10:19:26 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 10:19:26 +0200
In-Reply-To: <s2kc731536d1004052206t279dd76au1804bd0d8339cec8@mail.gmail.com>
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

'Twas brillig, and Pradeep Kumar Jilagam at 06/04/10 06:06 did gyre and
gimble:
> Hi Daniel,
> 
> Thanks for your response.
> 
> I am trying to get this working on a small embedded system with limited
> memory and processing capabilities. I have also explored in the direction of
> pulseaudio but I am not sure whether it is small enough to fit into a small
> system.

Most of the linux-based embedded and mobile phone manufacturers are
using PA these days (certainly Palm, Nokia and Intel), so I don't see a
major headache here. There are specific optimisations for ARM in the PA
codebase too.

 Aslo, I I came to know that the default output device will again
> have to be manually changed in the GUI menu fo pulseaudio to start streaming
> on the BT headset after updating asoundrc with its MAC address.

Using the ALSA bluetooth support is likely not going to work too well.
PA has direct bluetooth support these days. All the upstream (bluez)
effort regarding audio on linux is via PA. PA will automatically
discover BT devices and once they are paired, they will appear
automatically as sinks/sources in PA.

You can use various command line tools to change the device of a running
stream. You can also write a program and use the libpulse capabilities
to programatically move the streams.

> I am trying to find out whether the streaming can automatically start
> routing to the BT headset as soon as it is detected without any need for
> user's intervention.

In theory yes, but in practice this is actually quite hard with the
current PA routing logic. I personally have some issues with it and want
to change things to make this use case easier.

Currently if all audio streams are tagged as "media.role=phone" then
they *will* be routed to a bluetooth device automatically if one is
present. So that's probably the cleanest approach.

HTHs

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
