From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: caps-bug (fwd)
Date: Thu, 22 Apr 2010 08:30:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004220828430.16336@eeebox2.perex-int.cz>
References: <Pine.LNX.4.64.1004191410310.2993@spring.q>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 207F5103803
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 08:30:22 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.1004191410310.2993@spring.q>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Apr 2010, Tim Goetze wrote:

> Hello alsa team,
>
> please find attached a bug report I received a short while ago.  The
> finder isolated the problem on his own.  It turned out that the "type
> equal" pcm slave ran the stereo plugin "Eq2x2" without connecting all
> of the plugin's input and output ports.  This is in violation of
> ladspa.h, which mandates:

Note that alsaequal plugin is not in any ALSA package. The homepage for 
this plugin seems to be here:

http://www.thedigitalmachine.net/alsaequal.html

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
