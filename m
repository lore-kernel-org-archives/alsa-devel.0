From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Problems with Extigy mixer settings.
Date: Tue, 09 Mar 2004 15:18:49 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <404DE059.5070401@superbug.demon.co.uk>
References: <1078343986.6219.23.camel@Fizban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078343986.6219.23.camel@Fizban>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommy Schultz Lassen <tommy@tlassen.dk>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I would like to add that this patch has been tested by someone on #alsa
in irc.freenode.net and confirmed as a fix.

Please add this to the alsa cvs.

Cheers
James


Tommy Schultz Lassen wrote:
> Hi
> 
> I have been having som problems with mixer settings on my Sound Blaster
> Extigy. 
> 
> I am using the alsa from the linux 2.6.3 kernel. White alsa's usbaudio. 
> 
> When starting it wood fail. When i set #define IGNORE_CTL_ERROR in
> usbmixer.c it wood load but when alsamixer came to the settings for the
> digital In mixer port it wood start printing errors to the console.
> 
> This patch fixes it by disabling the mixer channel which gave the
> problems.
> 
> Tommy
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.3/sound/usb/usbmixer_maps.c	2004-02-25 18:22:10.000000000 +0100
> +++ linux-2.6.3-usbaudio/sound/usb/usbmixer_maps.c	2004-02-26 21:32:54.000000000 +0100
> @@ -86,6 +86,7 @@
>  	{ 26, "IEC958 Optical Playback" }, /* OT */
>  	{ 27, NULL }, /* DISABLED: EU (for what?) */
>  	/* 28: FU speaker (mute) */
> +	{ 29, NULL /*"Digital In Playback Source"*/}, /* */
>  	{ 0 } /* terminator */
>  };
>  




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
