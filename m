From: Mark Knecht <markknecht@attbi.com>
Subject: HDSP 9652 Status Request
Date: 03 Apr 2003 18:42:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049424152.1709.38.camel@Wizard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   I'm just checking in to see what progress has been made on getting
this patch Paul did to support RME's new firmware for the HDSP series
into CVS. I've been literally down for 4-5 weeks now waiting for this. I
am completely unable to run Alsa at all without this patch.

   Can someone please provide an update on where all of this has
progressed to?

Thanks,
Mark


* From: Paul Davis
* Subject: Re: [Alsa-devel] NEW hdsp 9652 problems 
* Date: Fri, 21 Mar 2003 10:06:21 -0800

>Now, this all worked fine on the previous 2.4.19-1.ll kernel from the
>PlanetCCRMA site **BEFORE** I updated firmware on the HDSP 9652 for new
>Win XP driver support. After updating firmware for the card, the
>alsaconf program I had for the 2.4.19-1.ll kernel no longer recognized
>the card at all and cannot write anything in modules.conf.

you cannot use the current ALSA driver with the new firmware.

i submitted a patch to handle the new firmware, but it has not been
put into CVS yet. meanwhile, thomas charbonnel has extended the work i
did and added some more stuff, and so we are working on a "mega-patch"
that fixes lots of issues with full HDSP support.

once thomas gets his tasklet problems fixed (for MIDI I/O without
affecting PCM latency), we'll submit the patch again.

--p







-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
