From: Barratis <barratis@gmail.com>
Subject: snd_device_register / snd_device_disconnect
Date: Mon, 14 May 2012 08:23:47 +1000
Message-ID: <CAM+d0wJoZiooOAVMD97ETefnTZfwvA3Xbx9DF7D8M4_5k_YQdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0676D248A9
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 00:24:08 +0200 (CEST)
Received: by obbup19 with SMTP id up19so6767135obb.38
	for <alsa-devel@alsa-project.org>; Sun, 13 May 2012 15:24:08 -0700 (PDT)
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

Hi All,

I would have a question regarding the behavior of snd_device_register.

Currently, the register operation will only be carried out if the
state is SNDRV_DEV_BUILD. This effectively prevents device which have
been disconnected via snd_device_disconnect (and thus having the state
SNDRV_DEV_DISCONNECTED) to be registered again.

Is this a wanted behavior? If so, I can't seem to find a reason for
this as per my testing and code reading registering a device in
DISCONNECTED sate works just fine.

Thanks,

-- 
Barratis
