From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Thu, 7 Oct 2010 10:10:11 +0200
Message-ID: <20101007081010.GZ7159@buzzloop.caiaq.de>
References: <4C9DC7A1.8050001@showlabor.de> <4CA5BF35.2030108@showlabor.de>
	<4CA60C5B.6010809@ladisch.de> <4CA86E1A.30405@showlabor.de>
	<4CAAD212.9090805@ladisch.de> <4CAC804A.8040806@showlabor.de>
	<4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E025243E3
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 10:10:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CAD6AA2.4050205@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 07, 2010 at 08:37:22AM +0200, Clemens Ladisch wrote:
> Felix Homann wrote:
> > Am 06.10.2010 16:38, schrieb Clemens Ladisch:
> > > this device does not use frequency feedback.
> > >
> > > What happens when you are recording something and then try to play
> > > something else with a different sample rate?
> > 
> > When I start recording at 44.1 kHz while playing a wav at 48 kHz the
> > playback gets very distorted, sounds like lots of missing samples.
> 
> So this device expects the computer to take the sample clock from the
> capture data.   This is just like the UA-101; it should be possible to
> write a similar driver (with opportunities for code sharing, and AFAIK
> UAC 2 requires such a feedback mode, too).

Ah, that makes sense, yes. UAC2 calls this mode "implicit feedback".
Felix, can you provide a dump of "lsusb -v" for this device?

Daniel
