From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Effect of CONFIG_SND_PCM_OSS_PLUGINS
Date: Fri, 27 Jul 2007 08:21:23 +0200
Message-ID: <1185517283.21908.1202305699@webmail.messagingengine.com>
References: <92a12cdb0707241530h3703a721md7bceeac2cd3144a@mail.gmail.com>
	<1185345398.10658.1201916763@webmail.messagingengine.com>
	<92a12cdb0707261400u624be88av154447e7ea5be081@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B88E124479
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 08:21:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <92a12cdb0707261400u624be88av154447e7ea5be081@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> On 25/07/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > Well, your driver does support S16_LE, doesn't it?
> 
> I think so
> 
> .formats =
> 	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
> 	     SNDRV_PCM_FMTBIT_IMA_ADPCM),

Looks OK.

What are the other snd_pcm_hardware settings?


Regards,
Clemens
