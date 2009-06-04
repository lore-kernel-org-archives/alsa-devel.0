From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Sound streaming application: which device to use?
Date: Thu, 04 Jun 2009 15:30:01 +0100
Message-ID: <h08lp9$qmo$1@ger.gmane.org>
References: <45c981ab0906040428v3910cbcfq7e3024b23f6653e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CCF31037FD
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 16:30:18 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MCDxN-0000vt-LM
	for alsa-devel@alsa-project.org; Thu, 04 Jun 2009 14:30:13 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 14:30:13 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 14:30:13 +0000
In-Reply-To: <45c981ab0906040428v3910cbcfq7e3024b23f6653e1@mail.gmail.com>
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

'Twas brillig, and Lex Wassenberg at 04/06/09 12:28 did gyre and gimble:
> I'm working on an application which receives sound chunks via an IP
> connection, and it should use the local sound card to make this sound
> audible. Up to now it used OSS, but there were some problems with
> that, so I'm busy with rewriting the application to ALSA. The sound is
> 16-bit stereo, sampled at 8000 Hz, and it comes in chunks of 1024
> frames. I managed to get things more or less working, but there are
> still some things unclear to me.

Depending on the use case of your application, have you considered 
writing a pulseaudio module instead.

Pulseaudio already integrates with wireless and network systems for 
audio, notably bluetooth, Apple RAOP/Airtunes, and it's uPnP media 
stuff, RTP streams and it's own network protocol.

It would be fairly easy to hook up a remote device like this and have it 
"play" the sound via pulseuaudio.

You'll be needing some kind of daemon/background process anyway to 
listen on the network so this may be a better construct for you to work 
with rather than having to worry to start your "listener" app.

There may be many reasons why this wouldn't work for you but figured it 
was worth mentioning.

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
