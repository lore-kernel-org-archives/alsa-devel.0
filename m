From: "Kuball, Martin" <Martin.Kuball@fja.com>
Subject: question about aplay code (v0.5.10)
Date: Thu, 4 Apr 2002 13:27:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <6380966D8BCFD5119C9300306E1C8487033619@clg-server7.clg.fja.de>
Mime-Version: 1.0
Content-Type: text/plain
Received: from fja.de (mail.fja.de [194.120.150.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA13437
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 13:27:02 +0200
Received: from muc.fja.de (susi02.muc.fja.de [172.16.40.16])
	by fja.de (8.11.6/8.11.6) with ESMTP id g34BQu319297
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 13:26:56 +0200
Received: from MUC-SERVER7.muc.fja.de (node1.muc.fja.de [172.16.30.61])
	by muc.fja.de (8.11.6/8.11.6) with ESMTP id g34BQrr11670
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 13:26:53 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Hi!
>  
> I tried to write some programs for sound processing recently. Most of it
> went very well, but some questions about the aplay code (version 0.5.10),
> which I used as example, remain unanswered. Maybe some of you can help me.
>  
> The first is: In the capture_go method a buffer is filled using
> snd_pcm_plugin_read and than written directly to a wave file. The
> documentation says that in block mode the driver returns the data for each
> channel in a separate  part of the buffer. But wave files expect the
> samples
> to be interleaved.  As arecord does indeed work, some of my thoughts must
> be
> wrong. But which one is it?
> 
> And the second one: Why is the size of a fragment choosen to be a power of
> 2? Why not a multiple of os_page_size * number_of_voices? Is it just the
> programers preference or is there a good reason for it?
>  
> Martin
> 
