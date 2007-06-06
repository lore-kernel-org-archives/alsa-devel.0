From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problem restarting alsa: can't set buffer size
Date: Wed, 06 Jun 2007 08:21:51 +0200
Message-ID: <1181110911.8385.1193688563@webmail.messagingengine.com>
References: <ef9bc5590706051211x6721440esab78f04e1f987913@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0943C243B6
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 08:21:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ef9bc5590706051211x6721440esab78f04e1f987913@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juan Manuel Lopez Baio <jmbaio@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Juan Manuel Lopez Baio wrote:
> The problem is that afterwards, if I restart the application, I can't set up
> ALSA, becausea continuous calls to snd_pcm_hw_params_set_buffer_size always
> fail  (I start with a buffer size of 8192 and keep dividing it by 2).

What values are returned by snd_pcm_hw_params_get_buffer_size_max()
and _min()?

Why do you try to set a buffer size?

> I finally have to restart the system in order to get it to work again.

Which sound driver are you using?


Regards,
Clemens
