From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: Full support for Creamware Noah and SFP
Date: Wed, 10 Mar 2004 19:40:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078944051.2445.10.camel@chief.local>
References: <1078875033.13147.42.camel@zauberwald.zeitgeist>
	 <Pine.HPX.4.33n.0403100909080.2498-100000@studcom.urz.uni-halle.de>
	 <s5hfzchlzqq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzchlzqq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Willie Sippel <willie@froq.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 10 Mar 2004 11:28:39 +0100 (MET),
> Clemens Ladisch wrote:
> > 
> > AFAIK drivers for ATI hardware are developed in a similar way (ATI
> > gives specs under an NDA, the resulting driver is open source).
> > 
> > Takashi, is that right?
> 
> yes.  but just make sure that you will release the driver source codes
> under GPL even after you get the datasheet under NDA.  that is, the
> information there can be used as a public form.
> (thus, in many cases, you don't need even NDA - it's just a question
>  of trust.)
> 
> BTW, the firmware binary is not a part of the driver, so it's not
> necessarily in the GPL form.  it can be distributed as a binary.
> i think many companies are afraid of opening their DSP source codes
> rather than the driver codes.  it's no problem if the DSP is apart
> from the driver.
> 
> 
> Takashi
> 

I think we've to split the theme to different parts.

- an usb driver for the Noah with the capabilitiy to use both usb
configurations (control and midi/audio) at the same time.

-an another (pci)driver to support the creamware DSP-cards.

- an user-space application to manage the different cards, devices and
uploadable plugins

As I understood Willie, the drivers aren't a subject of the NDA.

The NDA covers only the details of the user-space application.

Hartmut
-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
