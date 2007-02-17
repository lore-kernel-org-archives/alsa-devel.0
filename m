From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: trying to get sound working at a mac book pro
	(core 2 duo)
Date: Sat, 17 Feb 2007 14:42:17 +0000
Message-ID: <564d96fb0702170642p38089e6cy5303813a50e03c98@mail.gmail.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
	<1171482019.7083.8.camel@razman.gruemaster.com>
	<564d96fb0702141209g6b032115pebe2ce1a7e3de57b@mail.gmail.com>
	<564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
	<564d96fb0702141256t55f2febbna1e9bbdf50c200d@mail.gmail.com>
	<s5hire4l6ho.wl%tiwai@suse.de>
	<1171502000.7083.23.camel@razman.gruemaster.com>
	<s5hsld7aack.wl%tiwai@suse.de>
	<564d96fb0702151155q8d568ebj91ad7488faf1be6a@mail.gmail.com>
	<s5hps8a8eto.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F07C139A
	for <alsa-devel@alsa-project.org>; Sat, 17 Feb 2007 15:42:17 +0100 (MET)
Received: by nf-out-0910.google.com with SMTP id n29so1793779nfc
	for <alsa-devel@alsa-project.org>; Sat, 17 Feb 2007 06:42:17 -0800 (PST)
In-Reply-To: <s5hps8a8eto.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> OK, now I committed the (slightly modified) patch to HG tree.
> If you find more better pin configs, please create a patch on the top
> of HG tree and submit it here (and me to Cc).

Looking at the ioreg output on mac os I was able to find 4 different configs:

static unsigned int macbook_pro_pin_configs_2[10] = {
        0x012b4050, 0x90a00110, 0x90100140, 0x400000f0,
        0x400000f0, 0x018b3020, 0x014be060, 0x01cbe030,
        0x400000f0, 0x400000f0,
};

static unsigned int macbook_pro_pin_configs_4[10] = {
        0x012b4050, 0x90a00110, 0x90100140, 0x90100141,
        0x400000f0, 0x018b3020, 0x014be060, 0x01cbe030,
        0x400000f0, 0x400000f0
};

static unsigned int macbook_pro_pin_configs_6[10] = {
        0x012b4040, 0x90a00110, 0x90100130, 0x400000f0,
        0x400000f0, 0x018b3020, 0x014be050, 0x400000f0,
        0x400000f0, 0x400000f0
};

static unsigned int macbook_pro_pin_configs_8[10] = {
        0x012b4040, 0x400000f0, 0x90100130, 0x400000f0,
        0x400000f0, 0x018b3010, 0x014be050, 0x01cbe020,
        0x400000f0, 0x400000f0
};

the config number 2 almost works. I had to replace 0x018b3020, with
0x010b3020. I.e. replace the line-in with an dummy line-out. With this
modification I have the following items on alsamixer:

headphone, PCM, Front, Mic as Output, IEC958, Capture, Input Source,
Mux, Speaker

Front and "Mic as Output" are dummy. The other ones work and I can set
different volumes for the headphone and the speaker :-)

If I add the line-in again, the speaker no longer works and the
control names in alsamixer are wrong. Any suggestions?

Thanks,
Rafael

P.S.: I have just remembered to upgrade the alsa libs and utils. I
will send another email if it works.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
