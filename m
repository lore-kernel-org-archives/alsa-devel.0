From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ALSA related comments - please correct
Date: Sun, 21 Dec 2003 15:42:13 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE5BF55.8030105@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0312210802500.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA06674
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2003 16:40:14 +0100
In-Reply-To: <Pine.LNX.4.58.0312210802500.8959@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: press@transgaming.com, info@transgaming.com, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hello,
> 
> 	we discovered your notes about ALSA (Advanced Linux Sound 
> Architecture) on your web pages:
> 
> http://www.transgaming.com/showthread.php?news=98
> 
> 	Please, let me comment ALSA issues. Perhaps, your development 
> people should contact us directly before making such bad assumptions.
> 
> 
>>ALSA, of particular interest to TransGaming's Linux audience, does not
>>provide much of an added benefit over OSS. The primary speed advantage,
>>hardware mixing, a slower kludgy implementation use due to the fact that
>>looping sound doesn't appear to be supported; although full duplex
> 
> 
> What's looping sound? You can initiate endless ring buffer looping when
> you set stop_threshold to boundary (sw_params). I think that this 
> major drawback does not exist.
> 
> 
>>support should be easier to provide than with OSS. The major drawback of
>>ALSA is that its mmap interface is not compatible with what is required
>>for DirectSound unless undocumented interfaces are used. All in all it
>>appears that using ALSA would provide some speed advantages for newer
>>cards, but to be done properly would require a rewrite of the winealsa
>>driver. Thus we would suggest that, for the time being, people continue
>>to use the OSS emulation layer of ALSA with "MMap" = "Y" enabled in
>>their config file to get the best performance if it's supported on their
>>sound card.
> 
> 
> We can do everything with our API like OSS and our API has many other 
> extensions which OSS does not have.
> 
> Again, please, tell your developers that they are wrong and remove this 
> paragraph from your pages, because this text hurt us.
> 
> 						Jaroslav Kysela
> 						The ALSA project leader
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
Jaroslav, wine's support for alsa has always been badly implemented. I 
have had to use wine's oss module linking to alsa emulation to get sound 
out. If someone from the wine project can educate me on the win32 sound 
api, I am sure I could get wine to support alsa properly.
Whether win32 needs mmap, callback model, and looping, alsa can be made 
to handle all these.
I will probably do it for wine instead of winex though, because I would 
want the resulting code to be free, and not cost money like winex does.

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
