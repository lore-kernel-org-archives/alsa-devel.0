From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] hda_intel: Add Oaktrail identifiers
Date: Wed, 04 Jan 2012 12:55:04 +0100
Message-ID: <4F043E18.1080903@canonical.com>
References: <20111228151715.2032.87840.stgit@bob.linux.org.uk>
	<s5hzke8n0o6.wl%tiwai@suse.de>
	<20111231170001.22cdabdd@pyramind.ukuu.org.uk>
	<4F0210CE.1020007@canonical.com>
	<20120103230609.1e3a71ed@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id CD69E243F4
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 12:55:06 +0100 (CET)
In-Reply-To: <20120103230609.1e3a71ed@pyramind.ukuu.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/04/2012 12:06 AM, Alan Cox wrote:
>> Btw, you seem to be employed by Intel these days? [1] Any chance you can
>> talk to your firmware developers of this chip? I assume somebody at
>> Intel should know what method to prefer. That would be the safest/best
>> option IMHO.
>
> Indeed I am and by the time I got around to looking at it other Intel
> folsk on the list were already digging. Yes we think it needs the same
> settings as Poulsbo.

While we're at it, I tried to backtrace the PCI Vendor ID:s for the 
individual machine quirks we have, and came up with the following list:

8086:27d8 (rev 01) (Intel Corporation N10/ICH 7 Family) - appeared twice
8086:284b (rev 02) (Intel Corporation 82801H (ICH8 Family))
8086:293e (rev 03) (Intel Corporation 82801I (ICH9 Family))
8086:3b56 (rev 05) (Intel Corporation 5 Series/3400 Series)

If you don't mind doing some more lurking, do you think any of the above 
chips should be tweaked to use LPIB position fix method for the entire 
chip, and not just the individual machine?

(For the sake of completeness, 1106:3288 (rev 10) (VIA Technologies, 
Inc. VT1708/A [Azalia HDAC]) also appeared three times.)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
