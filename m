From: "Ian E. Morgan" <penguin.wrangler@gmail.com>
Subject: Loud POP from sound system during module init w/ 2.6.19
Date: Fri, 8 Dec 2006 13:53:46 -0500
Message-ID: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767__30723.3826526955$1165604092$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.242])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 338112DC
	for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2006 19:53:54 +0100 (MET)
Received: by ag-out-0708.google.com with SMTP id 8so464831agc
	for <alsa-devel@alsa-project.org>; Fri, 08 Dec 2006 10:53:46 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>, perex@suse.cz, alsa-devel@alsa-project.org, emu10k1-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Since upgrading to 2.6.19, two of my boxes (one workstation, one
notebook) started making a very loud (and scary) POP from the sound
system when the alsa modules are loaded. Unloading and reloading the
modules will generate another pop.

I have removed any fiddling of mixer settings during module
load/unload; same results.

I have complied the kernel both with and without
CONFIG_SND_AC97_POWER_SAVE; same results.

The workstation uses snd_emu10k1, the notebook snd_intel8x0, so it's
affecting more than a single driver.

Anybody else seeing this behaviour and know how to stop it?

-- 
Ian E. Morgan
penguin.wrangler@gmail.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
