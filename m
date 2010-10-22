From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Fri, 22 Oct 2010 11:45:36 +0200
Message-ID: <4CC15D40.9070606@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>	<4CBFEE94.7020103@gmail.com>	<s5hlj5sc7do.wl%tiwai@suse.de>	<4CBFF25C.2080908@gmail.com>	<s5hfww0c6oj.wl%tiwai@suse.de>	<4CC085F5.9070905@gmail.com>	<s5heibjxsi4.wl%tiwai@suse.de>	<4CC092BC.9060504@gmail.com>	<s5h8w1rxrl3.wl%tiwai@suse.de>	<5220.1287692957@localhost>	<s5h39rzclx3.wl%tiwai@suse.de>	<8089.1287696264@localhost>	<s5hsjzzb5cf.wl%tiwai@suse.de>	<4CC0B3C1.9010106@gmail.com>	<4CC14F4E.4090509@colin.guthr.ie>	<s5hmxq6bnwj.wl%tiwai@suse.de>	<4CC156ED.8000104@gmail.com>
	<s5hiq0ubm5e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C6532437F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 11:45:41 +0200 (CEST)
Received: by eyg24 with SMTP id 24so233644eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2010 02:45:40 -0700 (PDT)
In-Reply-To: <s5hiq0ubm5e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, Colin Guthrie <gmane@colin.guthr.ie>, clemens@ladisch.de, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 10/22/2010 11:40 AM, Takashi Iwai wrote:
> Hrm, is it with alsa.rpm and libasound2.rpm from OBS
> multimedia:audio:snapshot repo?

Aha, I dupped in the meantime and it vanished.

With the revert:
http://www.alsa-project.org/db/?f=7b9b41e9494674b1e5a8ec0b5dd250058ecff887

Without the revert:
http://www.alsa-project.org/db/?f=dc92721d4587f8f6289dfb25eb0ac523a2704f21

regards,
-- 
js
