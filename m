From: Wolfgang Rosenauer <wolfgang@rosenauer.org>
Subject: Re: Alsa 32-64 bit issue
Date: Thu, 03 Jul 2008 13:28:11 +0200
Message-ID: <486CB7CB.2040805@rosenauer.org>
References: <486B6B02.4020202@rosenauer.org>
	<s5h1w2ccwj4.wl%tiwai@suse.de>	<486B7726.1040608@rosenauer.org>
	<486BCBF9.2090906@rosenauer.org> <486BD1E3.8020806@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ds9.rosenauer.org (ds9.rosenauer.org [78.47.28.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 714AA248B9
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 13:28:14 +0200 (CEST)
In-Reply-To: <486BD1E3.8020806@tet.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Gustavo da Silva Serra wrote:
> If I am not wrong, a buffer underrun occurs when a playback application 
> can't feed the audio buffer fast enough. You could adjust 
> /etc/asound.conf according to your sound card, or verify if your 
> application isn't taking too long to write to the audio buffer.

I found out that it's really the application which doesn't feed the 
buffer fast enough.
The difference is not the architecture but the sound hardware.
The buffer size is just 1016 frames on that sound card which is pretty 
small.

Wolfgang
