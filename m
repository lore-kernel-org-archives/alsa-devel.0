From: Ng Oon-Ee <ngoonee@gmail.com>
Subject: Re: Alsa plugin unable to be loaded by Pulseaudio
Date: Thu, 10 Sep 2009 16:54:02 +0800
Message-ID: <1252572842.5434.2.camel@localhost.localdomain>
References: <1252365377.11542.5.camel@localhost.localdomain>
	<4f3252890909090110n68cbecefnab64f953d4788850@mail.gmail.com>
	<1252502217.20038.3.camel@localhost.localdomain>
	<20090909135939.GA14530@tango.0pointer.de>
	<1252505762.2154.1.camel@localhost.localdomain>
	<1252508405.6667.1.camel@localhost.localdomain>
	<4f3252890909092340h2124ec75o48a9af009c763312@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f191.google.com (mail-yx0-f191.google.com
	[209.85.210.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 20B21245E1
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Sep 2009 10:54:59 +0200 (CEST)
Received: by yxe29 with SMTP id 29so10132066yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2009 01:54:58 -0700 (PDT)
In-Reply-To: <4f3252890909092340h2124ec75o48a9af009c763312@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

Thanks for your assistance. I have mentioned previously that aplay works
fine with alsaequal, my problem all along was getting it to load in
Pulseaudio. Lennart took this discussion off-list, when a solution is
forthcoming, or more info requirements, we'll bring it back here.

On Thu, 2009-09-10 at 14:40 +0800, Raymond Yau wrote:
> Post the output of
> 
> aplay -v -Dplug:plugequal any.wav
> 
> AFAIK , ladspa plugin use float as Input and output
> 
> 
> 2009/9/9 Ng Oon-Ee <ngoonee@gmail.com>
> 
> >
> > Ah, the git download was quicker than I expected. I've tested it out,
> > and the 'test' case shown above does work now, thanks.
> >
> > Unfortunately the main root of my question was to use the 'alsaequal'
> > plugin from http://www.thedigitalmachine.net/alsaequal.html which still
> > does not work. Same error as previously.
> >
