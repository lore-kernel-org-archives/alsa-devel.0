From: Singaravelan Nallasellan <singaravelann@gmail.com>
Subject: rewind operations in pcm_ops
Date: Wed, 2 Dec 2009 20:13:36 +0530
Message-ID: <3baf3d760912020643s2806ae11k3ae6ba564e79fc75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 769922459E
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 15:43:38 +0100 (CET)
Received: by pxi15 with SMTP id 15so171466pxi.23
	for <alsa-devel@alsa-project.org>; Wed, 02 Dec 2009 06:43:36 -0800 (PST)
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

The audio subsystem in platform has its own buffering. It could buffer
upto 256KB. Our driver uses indirect callback to send the buffers and
sizes to audio subsystem whenever the "ack" is called. If rewind is
required during the playback, ALSA pcm native interface is not calling
the driver operations for rewind.

I am planning to add rewind operations to pcm_ops and make changes to
pcm files. Please suggest me whether this is acceptable.

Thanks
-Sing
