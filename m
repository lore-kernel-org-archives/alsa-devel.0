From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 23 Oct 2008 14:56:42 +0100
Message-ID: <4900829A.8000703@oliford.co.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 7466E2450E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 15:57:09 +0200 (CEST)
In-Reply-To: <20081023132705.GA20557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> BTW, when posting stuff with amixer please use the plain text version of
> the control name rather than the numeric ID - it makes life very much
> easier.
>   
Ok, will do. This also reminds me of something that might help...

The offending mixer switch has the truncated text name 'Speaker Mixer 
PCM Playback Swit' under amixer but it obviously is supposed to be 
'Switch' on  the end. I don't know if that might somehow cause problems?

Oliver
