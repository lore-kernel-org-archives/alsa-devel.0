From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp9632 mixer fix + gcc 2.9x compile fix
Date: Fri, 07 Nov 2003 15:33:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FABAD2E.5080202@undata.org>
References: <3FAA408F.50201@undata.org> <3FAB5CE6.70306@ifrance.com> <3FAB857A.80707@undata.org> <3FAB9C23.9020004@ifrance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FAB9C23.9020004@ifrance.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benouille <benouille@ifrance.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Benouille wrote :
> Thanks thomas,
> 
> you're right, I'm french... and your answer was very clear!
> /Franchement tu fais un super bouleau, et notamment le hdspmixer est une 
> pure
> merveille./

Merci :)

> 
> Since this mailing list is not in french , I prefer to answer in english.
> 

I also sent a translation to the list, but it didn't show up yet (smtp 
problems ?)

> About the problem of loading the firmware in the hdsp multiface, I'll 
> try to explain my experience:
> After I boot linux, the multiface is still locked (red light host error 
> is on). Then, I need to run hdsploader 3 or 5 times (maybe I should wait 
> a bit more between each one). Then, if I run hdspmixer to recall the 
> preset 1, I still can't hear any sound from the soundcard, and all 
> levels meters in hdspmixer stay null.
> If I reboot, no need to run hdsploader, since the firmware is already 
> there, I run hdspmixer, and here I can get output from the card.
> 
> It's not problematic, I just share my exeperience.
> For info: redhat 9, alsa cvs november 5th, Planet CCRMA kernel 2.4.22, 
> hdsp flash firmware v1.1
> 

Please try the patch I just sent to the list and tell me if the problem 
remains.

> A last question I know someone that have a hdsp 9652 with RME Analog 
> Expansion Board : 2 * 8 channels output and one 8 channels input. He 
> would like to install linux, do you know if it should work without 
> problem? (synchro problems?)
> 

If these are old style expansion boards (plugged on the internal ADAT 
connectors, I think these are the same as those for the old rme series) 
it should work without any change, you just have to check the AEB 
checkbox in the latest hdspconf (or use amixer to set the corresponding 
ctl accordingly). I only know of newer extension boards for the H9632 
series. These are also supposed to be supported, but it is untested yet.

> Thanks, thanks, and one more time: THANKS!
> 
You're welcome, I'm happy this is of some use :)

Thomas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
