From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: ALSA 1.0.0rc1 released
Date: Tue, 02 Dec 2003 10:16:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCCD6FF.30605@pianodisc.com>
References: <s5hu14kabjn.wl@alsa2.suse.de> <1070312195.3552.14.camel@Wizard.knechthome.com>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1070312195.3552.14.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

We went ahead and added code to our alsa client software to cleanly 
return to a PCM value of 0 and then stuffed a full buffer worth of 0s 
into the buffer before closeing the PCM in order to solve our pop 
problem.  I'm not sure how the OSS emulation stuff works since we don't 
use it, but maybe it could use this same treatment?  I'm assuming we 
don't want to change OSS client programs to fix it, so that would leave 
something in the emulation layer that should be changed.  Perhaps OSS 
automagically does this cleanup?  Mark, have you tried using the real 
OSS?  Do the pops happen with OSS?

Also, it seems strange to have to do this in client programs when the 
problem is with specific cards/chipsets not doing their own cleanup. 
Maybe the drivers of the cards should do the cleanup so the client 
software doesn't have to know what card they're running on?  Just 
putting this forward for discussion, not voluteering to do the work 
(I've already got my hands full with the serial MIDI driver, thanks). :)

- Steve

Mark Knecht wrote:
> Hi,
>    I want to report that I've built alsa-1.0.0rc1 under Gentoo with q
> 2.4.20-r7 kernel. Thanks to Thomas Charbonnel for the help with the
> ebuilds. If any other Gentoo users need the ebuilds, then contact me off
> list.
> 
>    Unfortunately this release does not impact my loud glitch/pop noise
> on the HDSP 9652 when using OSS applications. The results are the same
> as I reported over the last few weeks.
> 
>    I have not run significant Alsa audio yet to talk about how that's
> working. The OSS fix was the one I was most hoping for, and I haven't
> had many Alsa problems anyway.
> 
> - Thanks,
> Mark
> 
> On Mon, 2003-12-01 at 05:54, Takashi Iwai wrote:
> 
>>Hi,
>>
>>today we reached ALSA 1.0.0rc1 release.
>>as its name stands, this is the "release candidate" for 1.0.0.
>>if no show-stopper bug is reported, we'll release 1.0.0 really
>>soon.
>>
>>this version includes the following fixes since the last 1.0.0-pre3
>>release.
>>
>>Drivers:
>>- fixed OSS emulation on kernel.  quake and wine should work now.
> 
> <SNIP>
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
