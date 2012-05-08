From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Follow Up: "Why my linux OS has only 8 sound cards
 ? How can I modify it ?"
Date: Tue, 08 May 2012 15:02:33 +0200
Message-ID: <4FA91969.10000@ladisch.de>
References: <4FA9170E.60306@mobile.put.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 78498104341
	for <Alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:58:34 +0200 (CEST)
In-Reply-To: <4FA9170E.60306@mobile.put.edu.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maciej Paszta <maciej.paszta@mobile.put.edu.pl>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Maciej Paszta wrote:
> Quick reminder: I have  10 sound cards which need to have oss emulation
> enabled. However, I only see 8 devices (dsp-dsp7). Takashi suggested a
> patch to workaround this problem:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-November/045764.html
> I've applied it to kernel 3.0.0 and the only result I get is message
> appearing in kernel logs: "unable to register OSS PCM device 8:0". I've
> done some debugging and the registration fails on these lines
> (sound/core/sound_oss.c):
> register1 = register_sound_special_device(f_ops, minor, carddev);

Try replacing 128 with 256 in register_sound_special_device() in
sound/sound_core.c.


Regards,
Clemens
