From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP 9652 Status Request
Date: 04 Apr 2003 07:46:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049435183.1370.18.camel@satellite.undata.org>
References: <1049424152.1709.38.camel@Wizard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1049424152.1709.38.camel@Wizard>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Hi,
>    I'm just checking in to see what progress has been made on getting
> this patch Paul did to support RME's new firmware for the HDSP series
> into CVS. I've been literally down for 4-5 weeks now waiting for this. I
> am completely unable to run Alsa at all without this patch.
> 
>    Can someone please provide an update on where all of this has
> progressed to?
> 
> Thanks,
> Mark

Hi Mark,

I have been working on this patch for a moment. It is nearly finished
now. Unfortunately I couldn't spend much time on it this week. I'll be
back on it this evening. Expect a release quite soon. It'll be done by
the end of the week-end. Exciting features include : 96 kHz support,
midi I/O done in a tasklet, firmware loading from userspace application
(for multiface & digiface users, comes handy if the power supply of the
io box gets disconnected, avoids a reboot), plus nice fltk GUI to
control and display card settings (sample rate, preferred sync source,
spdif bits, sync state, etc...). You'll have to wait a little more for
the totalmix clone, but it's nearly finished too.

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
