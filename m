From: Benouille <benouille@ifrance.com>
Subject: Re: hdsp update
Date: Fri, 07 Nov 2003 12:18:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAB7F9D.6090606@ifrance.com>
References: <3FAA408F.50201@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FAA408F.50201@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi list, hi thomas,

A big thank you for all your great job on the rme hdsp.
I've installed the alsa cvs dated from the november 5th on 2 pc:
one with a hdsp multiface, one with a hdsp 9652.

Since this update, I can't access anymore the level of the channels with
amixer, and alsamixer reponds 'no mixer element found' on both system.
Is it a normal behaviour?

Then, when I boot, the hdsp multiface is still locked and I need to call
'hdsploader' about 3 or 5 times (I have the 'post-install snd-hdsp
/usr/local/bin/hdsploader' in modules.conf)
then, I have to reboot, and run hdspmixer to unmute the channels.
I woul like to know if there is a way to start the system with the card
properly running and all channels unmuted.
Maybe you could show us your modules.conf?

Thanks again,

Benoit



Le 06/11/2003 13:37, Thomas Charbonnel a écrit :
> Hi,
> 
> The attached patch fixes matrix mixer and metering problems spotted by 
> Pentti Ala-Vannesluoma for H9632 cards and gcc 2.9x compile errors 
> reported by Martin Langer.
> 
> Thomas
> 
> 
> ------------------------------------------------------------------------
> 
> --- hdsp.c.cvs	2003-11-01 09:06:45.000000000 +0100
> +++ hdsp.c	2003-11-06 13:06:28.000000000 +0100
> @@ -454,6 +454,7 @@
> ...






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
