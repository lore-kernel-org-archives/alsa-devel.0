From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Issue with Alsa and PulseAudio
Date: Tue, 26 Aug 2008 16:21:13 +0100
Message-ID: <g9171a$jko$1@ger.gmane.org>
References: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id F11ED24349
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 17:21:27 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KY0MG-0007TV-J2
	for alsa-devel@alsa-project.org; Tue, 26 Aug 2008 15:21:25 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 15:21:24 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 15:21:24 +0000
In-Reply-To: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>
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

Hi Ash,

Ash wrote:
> Hello, I have a media application that uses alsa as its sound
> renderer. It has worked on numerous systems without any problems
> until I came across a mandriva distro that bundles with PulseAudio.
> The alsa pulseaudio plugin is installed correctly, however I am
> having weird problems.
> 
> When I am setting up my hw params, and I call
> snd_pcm_hw_params_any(), I get an "Operation not permitted" error. I
> am not sure why this is happening, anyone else see this before? I am
> using pulseaudio version 0.9.9 and alsa 1.0.16.
> 
> Thanks in advance!

I'm the Mandriva PulseAudio maintainer. Most distros are now shipping PA 
by default now so I doubt your problem will be specific to Mandriva :)

However, I'm not expert enough in the ALSA API to know specifically what 
snd_pcm_hw_params_any() actually does, but I'd imagine (this is just a 
guess) that this is something that is either not implemented in the 
IOPLUG system (on which the pulseaudio alsa plugin builds) or something 
not implemented in the pulseaudio alsa plugin itself.

Hopefully someone more versed in this can explain the reason why it 
fails. :)

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
