From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: problem with  MU -LAW
Date: Tue, 01 Jul 2003 13:50:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F0183A8.3070906@superbug.demon.co.uk>
References: <20030701032432.30106.qmail@webmail26.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030701032432.30106.qmail@webmail26.rediffmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mahendra sp <mahendra_sp@rediffmail.com>
Cc: alsa-user-request@lists.sourceforge, alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

mahendra sp wrote:
> 
> hi, alsa  people,
> 
>   I have wriiten the application which realises full duplex.But there is 
> playback buffer underrun proble. The buffer tries to read the value but 
> -ve value. After writink the -ve value for some timesay 3 minutes, it 
> becomes alright. again after some time buffer under run occurs. whts 
> the  problem . how to over come it. is it dependednt on periodsize and 
> buffersize?
> 
>   and  also i want to implement G711. does it happen automatically by 
> using snd_pcm_format_mulaw? if not how to do it?
> 
> thanks, regards,
> mahendra
> ___________________________________________________
G.711 uses two audio formats. A-Law (Europe), and mu-Law(USA).

So, if one talks about A-Law and mu-Law, one is talking about G.711

Cheers
James




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
