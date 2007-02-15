From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: trying to get sound working at a mac book pro
	(core 2 duo)
Date: Thu, 15 Feb 2007 10:39:51 +0000
Message-ID: <564d96fb0702150239q40c7fb89x541124179630dfdd@mail.gmail.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Looking at the windows ini files I noticed that BOARD3.INI is the most
similar to the macbook pro: has an spdif input (code C) and an
internal microphone.

I am copying the config from BOARD3.INI to the linux driver. Currently
I am using:

static unsigned int macbook_pin_configs[10] = {
       0x0221401f, 0x90a70120, 0x01813024, 0x01014010,
       0x400000fd, 0x01016011, 0x1345e240, 0x13c5e22e,
       0x400000fc, 0x400000fb,
};

This is the best result so far:
*) mic works after switch to line in and back
*) speakers works
*) microphone works
*) microphone sensing works

Cheers,
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
