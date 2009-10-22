From: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
Subject: Problems with snd_pcm_writei() function
Date: Thu, 22 Oct 2009 15:34:43 -0200
Message-ID: <e0ab60670910221034u498448c5ja4eae8c2f4fd0f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f197.google.com (mail-vw0-f197.google.com
	[209.85.212.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE09244D7
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 19:34:44 +0200 (CEST)
Received: by vws35 with SMTP id 35so3122322vws.16
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2009 10:34:43 -0700 (PDT)
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

Hi,

I'm modifying an application that calls snd_pcm_writei() function from
libasound2-dev (on verstion 1.0.16-2). I does work.

I'm splitting my audio data into 160 bytes buffers but when buffer
with different size is passed to that function I hear a noise (like
'Krrr') on my audio device.
I tried to add zeroed bytes to complete the buffer but it didn't work.
I tried to ignore the last buffer and it worked but with some side
effects: No other operation worked properly after that.

Please, can anyone help?
Thanks in advance.
Regards,
Douglas
