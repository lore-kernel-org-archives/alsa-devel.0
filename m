From: gus.alsa@bourg.net
Subject: Re: Patch for Zotac IONITX model detection
Date: Wed, 7 Oct 2009 15:02:11 +0000
Message-ID: <40636.1254927731@bourg.net>
Reply-To: gus.alsa@bourg.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carrera.bourg.net (carrera.bourg.net [207.229.121.50])
	by alsa0.perex.cz (Postfix) with ESMTP id B2A3F24334
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 17:02:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, gus.alsa@bourg.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Aha, sorry - I misunderstood what was being asked to test.  Two channel audio is working correctly with the development snapshot.

Thanks,
Gus


On Wed  7/10/09 10:16 AM , Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 7 Oct 2009 03:12:49 +0000,
> wrote:
> > 
> > Hello Takashi Iwai,
> > 
> > I tested your latest snapshot and it did not detect the 6 channel
> audio.
> This is so per design.  The default auto-parser doesn't enable
> 6-channel since otherwise you get problems with the automatic HP /
> mic
> jack detection.
> Does it work except for 6-channel things?
> thanks,
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
Message sent via Atmail Open - http://atmail.org/
