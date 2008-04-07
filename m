From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: Flash Plugin & IO Plug: Async interface not
	implemented?
Date: Mon, 7 Apr 2008 17:49:26 +0300
Message-ID: <cab05a880804070749k4829d9aoc4f9eeb154b8eeee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 9100D2447F
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Apr 2008 16:49:38 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 50so1281588wri.2
	for <alsa-devel@alsa-project.org>; Mon, 07 Apr 2008 07:49:27 -0700 (PDT)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm trying to integrate Firefox Flash plugin with ASLA IO plug driver
for proprietary hardware.

I've found out that Flash Plugin ASLA client side (sources could be
found at http://labs.adobe.com/wiki/index.php/Flash_Player:Additional_Interface_Support_for_Linux)
is incompatible with IO Plug. The reason is that during initialization
Flash Plugin calls snd_async_add_pcm_handler() which always return
-ENOSYS out of snd_pcm_ioplug_async(). This error causes Flash Plugin
ALSA client code to fail.

Is there a good reason why snd_pcm_ioplug_async() unconditionally
return  -ENOSYS?
Is it possible to implement  IO Plug async interface?

Thank you for your help,
Alexander Indenbaum
