From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Fwd: via82xx problem
Date: Thu, 03 Apr 2003 14:44:27 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8BCA3B.8030107@boosthardware.com>
References: <3E854FD5.7070801@boosthardware.com> <s5h1y0nkjpt.wl@alsa2.suse.de> <20030402225838.GA5225@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Jordi Mallach <jordi@debian.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jordi Mallach wrote:
> On Mon, Mar 31, 2003 at 10:45:34AM +0200, Takashi Iwai wrote:
> 
>>please give the chip verison (listed in /proc/asound/cards in the
>>latest alsa driver).  and try pcm:0,1 (or /dev/adsp for oss) device.
>>this should work (almost) as same as 0.9.0rc6.
> 
> 
> Hi Takashi,
> 
> I'm seeing this same problem on my mother's box, which I just upgraded
> to 0.9.2.
> 
> 0 [8233A          ]: VIA8233A - VIA 8233A
>                      VIA 8233A at 0xe000, irq 5
> 
> Where do I set pcm:0,1? I know where to do it for just one app
> (QuakeForge), but not globally. Other apps just don't have where to set
> this. Is it using a module parametre?
> 
> Jordi


rm -rf /dev/dsp
ln -s /dev/adsp /dev/dsp
chmod a+rw /dev/dsp


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
