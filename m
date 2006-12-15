From: Pavel Polischouk <pavelp@rogers.com>
Subject: Re: [PATCH 1/2] M-Audio USB
Date: Thu, 14 Dec 2006 22:10:03 -0500
Message-ID: <4582120B.7050500@rogers.com>
References: <45675582.9060707@inbox.ru>	<s5h7ixhb0ns.wl%tiwai@suse.de>
	<20061203224225.67E1CA0D58E@zeus.olymp.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061203224225.67E1CA0D58E@zeus.olymp.home>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter Oehry wrote:
> - Sometimes the device gets messed up. In this state ther is a complete mess in 24-Bit mode and chagned byte-Order for 16-Bit. These problems are not reproduceable.
>   
This happens if "0" (enable all altsettings) parameter is specified. 
"Complete mess in 24bit mode" is the state when the driver thinks the 
device is in 24bit, but it's in fact in 16 bit. The fact that "changed 
byte-order" happens at all, suggests that the device IS capable of 
little-endian, but we don't know how to switch it. Must be some 
undocumented device parameter - it might be possible to reverse-engineer 
it by monitoring Windows driver, but I don't know how to do it :-(
> - Changing the device_setup without resetting the device will mostly not work.
> - The device seems to switch the sampling rate of inputs only after initialising an ouput with the same sampling rate.
>   
These tow seem to be the problem with FastTrack part of the patch ONLY. 
The reason is very simple: while Omni and Audiophile select only ONE 
altsetting for each driver configuration, FastTrack selects 2. If the 
patch is re-worked to only allow ONE altsetting per device_config, these 
problems will most likely go away.

Why these problems happen: during the init sequence, the driver goes 
through all altsettings, then SELECTS every one of them. This selection 
is OK for most USB-Audio devices, but not for M-Audio. Selecting an 
altsetting for any of its interfaces automatically switches ALL 
interfaces to this mode, and subsequent selection of another altsetting 
of a different interface turns the device into a non-working (sometimes 
recoverable, sometimes not) state.

> To solve these problems I'll need a lot more time. Maybe I have to go back to investigate the behaviour of the windows driver.
>   
Please send me some info how can I log the Windows USB activity, I wanna 
try to experiment with this
> Summary:
> - The driver works with the FastTrack but is way of to be a stable and final solution.
>   

Here's a new proposal.
Retire the "device_setup=MODE", where MODE is a bitmap of available 
sample rates and/or resolutions. Every device uses DIFFERENT altsettings 
for different combinations, it would be too burdensome to keep track of 
all the devices that require this hack and specifically add support for 
each one of them (and they will NOT work without this!)
Instead, add parameter "force_altsetting=NUMBER", which will apply to 
ANY device if specified. It will skip all altsettings instead of the 
selected one. It will be a matter of documentation for each M-Audio 
device to describe what each of these altsettings does. It would be 
possible to make any other M-Audio device work without patching the 
driver even further, just an exercise for the user to call the driver 
with each altsetting separately, figure out what it does and update the 
documentation. Also, the patch would be rather smaller.

Let me know what you think. I'll make the patch that implements this 
approach shortly.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
