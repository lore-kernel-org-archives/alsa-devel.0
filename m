From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Sat, 05 Jan 2013 05:45:10 +0100
Message-ID: <50E7AFD6.5050003@canonical.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de> <50E69ABD.40109@canonical.com>
 <20130105024917.GA11016@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0120B2616CF
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 05:45:13 +0100 (CET)
In-Reply-To: <20130105024917.GA11016@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/05/2013 03:49 AM, Jonathan Woithe wrote:
> On Fri, Jan 04, 2013 at 10:02:53AM +0100, David Henningsson wrote:
>> On 01/03/2013 11:39 AM, Takashi Iwai wrote:
>>> The jack retasking of the headphone input is still an open issue.
>>> I can provide a patch to add the support via "Headphone Jack Mode"
>>> enum, but David didn't like that approach.
>>
>> Meanwhile, there is hda-jack-retask utility (in the alsa-tools
>> package) that might be helpful for Jonathan?
>
> I discovered that utility during my initial investigations.  Unfortunately
> it requires GTK3 and I have not yet had an opportunity to upgrade the laptop
> to a distro version which includes it.  Given my schedule I suspect it's
> going to be several months before I get the chance.

Maybe I should add an ncurses interface ;-)

Anyway, if it's easier for you to read the HDA spec than upgrading your 
laptop, you can use the kernel interfaces directly using a "firmware 
patch" file or reconfigure sysfs. This is what hda-jack-retask uses.

The documentation for these interfaces are at 
http://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio.txt - see 
the "HD-Audio Reconfiguration" and "Early Patching" sections.

Or a compromise; boot up a live-CD of a newer distro, create the 
firmware file with hda-jack-retask, then copy the result back to your 
current distro setup.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
