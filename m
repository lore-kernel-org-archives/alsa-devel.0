From: Daniel Mack <daniel@caiaq.de>
Subject: Wrong sample rate user space -> kernel space?
Date: Tue, 7 Jul 2009 16:29:42 +0200
Message-ID: <20090707142942.GV18340@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C4E1D2445E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 16:29:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id F22857C8009
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 16:29:44 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NU5XzXkshjZ8 for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 16:29:42 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On a PXA embedded board, the sample rate propagation from user space to
kernel space seems to be wrong.

When I start aplay (v1.0.19) from userspace like this ...

    # aplay -f dat /dev/urandom 
    Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

... params_rate(params) in my snd_soc_ops .hw_params callback returns
88200, not 48000.

Can anyone reproduce this? I guess this is unrelated to PXA and ASoC.

Thanks,
Daniel
