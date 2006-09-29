From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Fri, 29 Sep 2006 15:44:01 +0100
Message-ID: <451D3131.9080507@superbug.co.uk>
References: <200609152111.03266.julian@jusst.de>	<200609191140.18077.julian@jusst.de>	<200609191356.20534.julian@jusst.de>
	<200609201152.57680.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609201152.57680.julian@jusst.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Julian Scheel <julian@jusst.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Julian Scheel wrote:
> Am Dienstag, 19. September 2006 13:56 schrieb Julian Scheel:
>   
>> Ok, attached is now what I've done so far. (patch against 1.0.13rc2) This
>> causes the WM8766 to be silent. Only way to get the noise back is
>> restarting the system without the init-code.
>> Couldn't find a reason for that behaviour. Maybe you have an idea what
>> could be wrong with that code?
>>
>>     
>
> One more note about that patch:
> I know coding-style is quite horrible and it'd probably break pontis. It's 
> just what I hacked together for testing, and as the DAC doesn't seem to 
> understand what I am sending I'd like to get some feedback on the 
> SPI-implementation, maybe that one is faulty? (The WM8766 sheet isn't very 
> detailed about that)
>
> -Julian
>   

After our conversation on IRC and the resulting help I was able to give 
you, I understand that you managed to fix this.
When are you going to post the completed patch?

James


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
