From: Willie Sippel <willie@froq.net>
Subject: Re: Full support for Creamware Noah and SFP
Date: Wed, 10 Mar 2004 00:30:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078875033.13147.42.camel@zauberwald.zeitgeist>
References: <1078855426.11076.36.camel@zauberwald.zeitgeist>
	 <1078869513.2430.28.camel@chief.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078869513.2430.28.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> I would really be amazed to have full Linux support for that device and
> I've some programming capabilities as well.
> 
> But I'm not sure about, wether the NDA agrees in the basic alsa
> principles. What are the developers of alsa are thinking about that
> agreement?

Hi Hartmut.

I even wanted to contact you and Clemens off-list on this topic...

I told Frank about the work you did on Noah support, and he was _very_
impressed. This even was one of the reasons he agreed on supporting
Linux, given a capable programmer would join the show...

Well, like I stated, the NDA would not really affect the driver, but the
tool to upload the plugins. It's just that CW needs to know what parts
of the current SFP solution are needed to provide basic support for the
platform. That driver would be OSS and the necessary specs should be
released, freely available to everyone without the need to sign a NDA.
Check here:
http://www.alsa-project.org/~cdavid/vendorinfo/call.html
The NDA Creamware wants you to sign does not restrict the release of the
sourcecode, so, everyone can access and modify the code - no problem
with the GPL.
It should work as follows:
1. Interested developers would sign the NDA.
2. Those developers would get the source and specs, and tell CW what
parts need to become open to get the hardware working.
3. CW releases those informations, an ALSA driver would be written,
enabling audio I/O and the control interface.
4. Interested developers would port the remaining parts of the SFP (the
plugin handler), to be released closed-source.

And, as you may know, the Luna/ Pulsar/ Powersampler cards are also part
of the SFP, and those cards are completely worthless for a Linux DAW
right now. And you wouldn't need to create your own control tool
anymore, 'cause the interface is already part of the .dev file - it uses
an interface description language similar to JavaScript for platform
independence...

I could bug-test the driver for Powersampler, and provide x86 and AMD64
binaries - PPC, anyone...? ;-)

Ciao,
-- 
Willie Sippel <willie@froq.net>
[ z ] !



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
