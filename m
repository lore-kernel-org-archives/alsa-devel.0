From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [alsa-devel] ALSA: pcsp: Use common error handling code in
 snd_card_pcsp_probe()
Date: Tue, 22 Aug 2017 15:15:02 +0200
Message-ID: <fc4d8c96-7de2-e8f0-4cb4-5dda795d298a@users.sourceforge.net>
References: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
 <20170822121625.syvr64kwyh5xjexg@mwanda> <s5hziar9483.wl-tiwai@suse.de>
 <f138ba40-a61f-cdab-3d9b-699dbcacad9d@users.sourceforge.net>
 <s5ho9r792yl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ho9r792yl.wl-tiwai@suse.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

>> Is it appropriate to treat non-zero values as error codes there generally?
> 
> No, it can't be in general.

I got the impression that the functions which are called at the updated places
by the function “snd_card_pcsp_probe” indicate a successful execution
only by zero so far.


> Lots of functions return a positive value, too.

Would you like to point any example out from the programming interface?

Regards,
Markus
