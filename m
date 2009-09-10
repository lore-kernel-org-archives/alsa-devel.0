From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsa plugin unable to be loaded by Pulseaudio
Date: Thu, 10 Sep 2009 14:40:47 +0800
Message-ID: <4f3252890909092340h2124ec75o48a9af009c763312@mail.gmail.com>
References: <1252365377.11542.5.camel@localhost.localdomain>
	<4f3252890909090110n68cbecefnab64f953d4788850@mail.gmail.com>
	<1252502217.20038.3.camel@localhost.localdomain>
	<20090909135939.GA14530@tango.0pointer.de>
	<1252505762.2154.1.camel@localhost.localdomain>
	<1252508405.6667.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f182.google.com (mail-pz0-f182.google.com
	[209.85.222.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 6191610387A
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Sep 2009 08:40:50 +0200 (CEST)
Received: by pzk12 with SMTP id 12so5117480pzk.6
	for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 23:40:49 -0700 (PDT)
In-Reply-To: <1252508405.6667.1.camel@localhost.localdomain>
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

Post the output of

aplay -v -Dplug:plugequal any.wav

AFAIK , ladspa plugin use float as Input and output


2009/9/9 Ng Oon-Ee <ngoonee@gmail.com>

>
> Ah, the git download was quicker than I expected. I've tested it out,
> and the 'test' case shown above does work now, thanks.
>
> Unfortunately the main root of my question was to use the 'alsaequal'
> plugin from http://www.thedigitalmachine.net/alsaequal.html which still
> does not work. Same error as previously.
>
>
