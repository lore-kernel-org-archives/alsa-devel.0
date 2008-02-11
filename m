From: Ben C <bchang_2@yahoo.com>
Subject: external PCM plugin, can't read hw params
Date: Sun, 10 Feb 2008 18:30:43 -0800 (PST)
Message-ID: <940755.82998.qm@web36515.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web36515.mail.mud.yahoo.com (web36515.mail.mud.yahoo.com
	[209.191.85.15]) by alsa0.perex.cz (Postfix) with SMTP id 35AA4244EF
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 03:30:45 +0100 (CET)
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

This is during the init call-back of an external PCM plugin.

I'm trying to read the period size. The code is pretty basic, it looks like this:

---------------
    snd_pcm_hw_params_alloca(&hw);
    status = snd_pcm_hw_params_any(ext->pcm, hw);
    if (status < 0)
    {
        // some error handling
    }

    status = snd_pcm_hw_params_get_period_size(hw, size, NULL);
    if (status < 0)
    {
        // some error handling
    }
--------------

I get size = 0 back, an no errors either. Other information that I needed, such as the rate & format are available in the ext structure, but not the period size. So I query the hw params of ext->pcm. Please let me know if I should be getting this information using a different way.

alsa-lib version is 1.0.14a

I've done something similar for alsa-lib verion 1.0.13 (I used snd_pcm_hw_params_current() call) which worked. This is based on that same code but for a different target.

Thank you,
Ben





      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
