From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-lib version info
Date: Fri, 16 Dec 2011 20:35:35 +0000
Message-ID: <201112162035.35666.gineera@aspect135.co.uk>
References: <201112142103.42310.gineera@aspect135.co.uk>
	<4EEB4D35.7070005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip08ir2.opaltelecom.net (out1.ip08ir2.opaltelecom.net
	[62.24.128.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 362E3103D15
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 21:33:40 +0100 (CET)
In-Reply-To: <4EEB4D35.7070005@ladisch.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 16 December 2011 13:52, you wrote:
> Alan Horstmann wrote:
> > I have read in the docs about snd_asoundlib_version() to get a version
> > string, but is there a way to get the SND_LIB_VERSION number from a
> > runtime Alsa-lib, rather than from the header included at application
> > build time,
>
> No.
>
> > or would it have to be constructed from the string?
>
> Why are you interested in the version number?  What are you actually
> trying to check for?

To be able to apply workarounds for 'mis-behaviours' of older versions of 
Alsa-lib, since the aim (Portaudio) is to work as widely as possible.  A 
single number along the lines of SND_LIB_VERSION makes a one-line comparision 
possible - eg less than (1<<16 | 0 | 14) means prior to 1.0.14 - to activate 
some little fix-up.

Thanks

Alan
