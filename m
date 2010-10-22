From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Fri, 22 Oct 2010 13:10:44 +0200
Message-ID: <4CC17134.2040706@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>	<4CBFEE94.7020103@gmail.com>	<s5hlj5sc7do.wl%tiwai@suse.de>	<4CBFF25C.2080908@gmail.com>	<s5hfww0c6oj.wl%tiwai@suse.de>	<4CC085F5.9070905@gmail.com>	<s5heibjxsi4.wl%tiwai@suse.de>	<4CC092BC.9060504@gmail.com>	<s5h8w1rxrl3.wl%tiwai@suse.de>	<5220.1287692957@localhost>	<s5h39rzclx3.wl%tiwai@suse.de>	<8089.1287696264@localhost>	<s5hsjzzb5cf.wl%tiwai@suse.de>	<4CC0B3C1.9010106@gmail.com>	<4CC14F4E.4090509@colin.guthr.ie>	<s5hmxq6bnwj.wl%tiwai@suse.de>	<4CC156ED.8000104@gmail.com>	<s5hiq0ubm5e.wl%tiwai@suse.de>	<4CC15D40.9070606@gmail.com>
	<s5h8w1qbk18.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C339024343
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 13:10:47 +0200 (CEST)
Received: by eyg24 with SMTP id 24so259460eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2010 04:10:47 -0700 (PDT)
In-Reply-To: <s5h8w1qbk18.wl%tiwai@suse.de>
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

On 10/22/2010 12:26 PM, Takashi Iwai wrote:
> I updated the version number and triggered rebuilds on OBS
> multimedia:audio:snapshot packages.  To be sure, install alsa.rpm,
> libasound2.rpm and alsa-utils.rpm later from the project.
> Now they should have version 1.0.23.git*.

alsa-1.0.23.git20101018-1.1.x86_64
alsa-firmware-1.0.23-3.7.noarch
alsa-oss-1.0.17-31.4.x86_64
alsa-plugins-1.0.23-4.5.x86_64
alsa-plugins-pulse-1.0.23-4.5.x86_64
alsa-plugins-pulse-32bit-1.0.23-4.5.x86_64
alsa-plugins-32bit-1.0.23-4.5.x86_64
alsa-utils-1.0.23.git20101022-3.1.x86_64
libasound2-1.0.23.git20101018-1.1.x86_64
libasound2-32bit-1.0.23-6.5.x86_64

> Also, you don't need to check the reverted kernel.  The only
> interesting thing is to see whether the dB range brokeness is fixed
> by alsa-lib update.

With patch not reverted (i.e. no sound):
http://www.alsa-project.org/db/?f=378efb40f8c5b1d6204e93221512506e7bb7b061

regards,
-- 
js
