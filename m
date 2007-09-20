From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: resetting an audio device?
Date: Thu, 20 Sep 2007 08:47:19 +0200
Message-ID: <1190270839.2316.1211624329@webmail.messagingengine.com>
References: <46F1B942.8000102@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B8ED0246CB
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 08:47:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46F1B942.8000102@popdial.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: william estrada <MrUmunhum@popdial.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

william estrada wrote:
>    I got my alsa player code to work.  Now I need to figure out how to
> reset the audio device?  I don't want to close the device, just recycle
> it.

When the device is not running (i.e., after calling snd_pcm_drop()),
call snd_pcm_hw_free() to free the configuration; then you can set a
new configuration with the snd_pcm_hw_params* functions.


HTH
Clemens
