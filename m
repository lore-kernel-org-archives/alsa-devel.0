From: Wiebe Cazemier <halfgaar@gmx.net>
Subject: Re: Inverted front speakers on sb live
Date: Tue, 11 Jul 2006 13:41:44 +0200
Message-ID: <e902po$fnl$1@sea.gmane.org>
References: <e8ihr6$jq$1@sea.gmane.org> <s5hodvwxw2o.wl%tiwai@suse.de>
	<e8vvnn$5qv$1@sea.gmane.org> <e901j8$bjj$1@sea.gmane.org>
	<s5hbqrw756o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 11 July 2006 13:26, Takashi Iwai wrote:

>> OK, this is proving to be difficult. When you start the patch server
>> (ld10k1), the DSP is cleared (at least mostly) and whatever initialisations
>> alsa did, like setting up the mixer, are gone. There is an init_live script
>> in the alsa-tools package, but I'm not sure if that sets it up like the
>> driver itself does. What's also curious, is that the effects contained in
>> the alsa-tools package are almost the same as the OSS EMU driver, except for
>> inv.asm, which solves the inversion problem.
>> 
>> Because the driver does it's own initialisation (DSP configuration and
>> routing and such), shouldn't it also take care of the inversion problem?
>> It's kind of strange that this problem is not addressed anymore in Alsa,
>> whereas it was in the OSS driver.
> 
> Yes, it'd be better to include it in the driver code, IMO.
> Which chip model is affected by this problem?

That is a good question. All I know is that "most" of em have it. It was stated
like this in the OSS emu docs, so perhaps the author of that document, or
people previously involved with the OSS driver, know it. Creative obviously
knows it, since their driver can correct the problem, but I don't think
they'll be very cooperative in answering questions.

My card is CT4832 [pci id: "1102:0002 (rev 08)"]

There are quite a number of chips out there, I bet this isn't the only one
affected.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
