From: Aner Gusic <aner@lysator.liu.se>
Subject: Re: problems with the mixer
Date: Fri, 14 May 2004 20:05:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040514180509.GA18636@sture.lysator.liu.se>
References: <20040508143705.GA7511@sture.lysator.liu.se> <s5h1xlrfci3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1xlrfci3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

* Takashi Iwai <tiwai@suse.de>:

> you can use "front", "rear" and "surround40" PCMs.
> then the volumes and the route should be initialized properly.

I've tryed playing some samples with aplay combined with -D parameter,
e.g. "aplay -Dfront foo.wav".  However, what I want is to play a
sample on both front and rear speakers, but control the sound level
independently, so what remains is the surround40-pcm.

When I try this (-Dsurround40) I get the following message:
aplay: set_params:837: Channels count non available

I've tried reading documentation in alsa-driver source-tree, but it is
sparse.  No documentation on the homepage that I found covers what I
am having problems with. :/  Any suggestions to where I should look?
Mostly, it should cover pcm:s, this "routing stuff" and such.

Thanks for your help,
/A

-- 
Aner Gusic,
LiTH
Sweden


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
