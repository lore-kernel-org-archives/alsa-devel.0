From: Benno Senoner <sbenno@gardena.net>
Subject: Re: ALSA related comments - please correct
Date: Sun, 21 Dec 2003 13:35:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE59376.3030909@gardena.net>
References: <Pine.LNX.4.58.0312210802500.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dns.gardena.net (dns.gardena.net [213.21.177.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA01876
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2003 12:34:58 +0100
In-Reply-To: <Pine.LNX.4.58.0312210802500.8959@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: press@transgaming.com, info@transgaming.com
List-Id: alsa-devel@alsa-project.org

I think transgaming should fully embrace ALSA otherwise they are hurting 
themselves.
OSS is DEAD and with kernel 2.6 most if not all distros will use ALSA by 
default while
providing an OSS emulation layer.
mmap is not necessarily needed for good performance and low latency and 
it would be
better if people implemented only a jackd interface to provide maximum 
benefits for users.
writing a jackd client is much easier than using ALSA, OSS etc directly 
plus you get all the
routing for free and you can totally forget about mmap and other 
soundcard specific stuff.

The future of audio on linux is called jackd clients, jackd that does 
audio I/O via ALSA.
Please remove OSS and /dev/dsp from your dictionary :-)

cheers,
Benno
http://www.linuxsampler.org

Jaroslav Kysela wrote:

>Hello,
>
>	we discovered your notes about ALSA (Advanced Linux Sound 
>Architecture) on your web pages:
>
>http://www.transgaming.com/showthread.php?news=98
>
>	Please, let me comment ALSA issues. Perhaps, your development 
>people should contact us directly before making such bad assumptions.
>
>  
>
>>ALSA, of particular interest to TransGaming's Linux audience, does not
>>provide much of an added benefit over OSS. The primary speed advantage,
>>hardware mixing, a slower kludgy implementation use due to the fact that
>>looping sound doesn't appear to be supported; although full duplex
>>    
>>
>
>What's looping sound? You can initiate endless ring buffer looping when
>you set stop_threshold to boundary (sw_params). I think that this 
>major drawback does not exist.
>
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
>>    
>>
>
>We can do everything with our API like OSS and our API has many other 
>extensions which OSS does not have.
>
>Again, please, tell your developers that they are wrong and remove this 
>paragraph from your pages, because this text hurt us.
>
>						Jaroslav Kysela
>						The ALSA project leader
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IBM Linux Tutorials.
>Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
>Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
>Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
