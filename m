From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: short writes?
Date: Sun, 30 Sep 2007 15:07:04 -0400
Message-ID: <20070930150704.2942ea30.alsauser@pragmasoft.com>
References: <46FFEF49.6070909@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E14243C0
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Sep 2007 21:01:28 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp6.server.rpi.edu (8.13.1/8.13.1) with SMTP id l8UJ1QK4028153
	for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2007 15:01:27 -0400
In-Reply-To: <46FFEF49.6070909@popdial.com>
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

On Sun, 30 Sep 2007 11:47:37 -0700
william estrada <MrUmunhum@popdial.com> wrote:

>  Now with all of that, is there a API call that will put the writei into
> blocking mode? 

snd_pcm_nonblock (pcm_handle, 0) ?

> Or an API call that will flush the output from writei?

snd_pcm_drain (pcm_handle) ?
