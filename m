From: Abramo Bagnara <abramo.bagnara@tin.it>
Subject: Re: DMIX and capture stream
Date: Wed, 07 Jan 2004 16:15:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFC229C.2020200@tin.it>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>	<200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com>	<s5h1xqe2rjp.wl@alsa2.suse.de>	<Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>	<20040106223828.39d2c233.mista.tapas@gmx.net>	<s5hvfno10r5.wl@alsa2.suse.de>	<3FFBFF51.1030002@tin.it>	<s5hptdv27pz.wl@alsa2.suse.de>	<3FFC1A12.7020901@tin.it> <s5hd69v245x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd69v245x.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 07 Jan 2004 15:39:14 +0100,
> Abramo Bagnara wrote:
> 
>>
>>I don't see your point, can you show me an example of what you mean?
>>
>>AFAICS the only code that need to be changed is the PCM definition lookup.
> 
> 
> there are two parts to be modified, snd_pcm_open_noupdate() and
> snd_pcm_slave_conf().  they are the parts which look up "pcm"
> directive in the configuration.
> the former is easy.  but the latter function doesn't have stream
> argument, so it cannot check whether "pcmp" or "pcmc" to check.  and,
> changing this function will need rewriting all callers...

I definitely don't see why you think snd_pcm_slave_conf need to be 
changed. It does not need to know about pcmp/pcmc variants.

I'm missing something?


-- 
Abramo Bagnara                       mailto:abramo.bagnara@tin.it

Opera Unica                          Phone: +39.0546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
