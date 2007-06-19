From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Changing the sample rate/channels of an already
 opened PCM stream
Date: Tue, 19 Jun 2007 07:59:42 +0200
Message-ID: <1182232782.12152.1195873653@webmail.messagingengine.com>
References: <20070618184758.GL27942@hoeg.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C86E32432E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 07:59:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070618184758.GL27942@hoeg.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ed Schouten <ed@fxq.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ed Schouten wrote:
> I have been trying to get the device to reset so I can change the sample
> rate, but for some reason, it just gets ignored. Can someone explain me
> how it's possible to reset the sample rate after preparing the handle?

The various snd_pcm_hw_params_set_xxx() functions choose some value for
a parameter that has not yet been set, but they do not change a
parameter once it has been set.  To reset all parameters in a hw_params
container, call snd_pcm_hw_params_any() again.


HTH
Clemens
