From: Pavel Polischouk <pavelvp@inbox.ru>
Subject: Re: snd-usb-audio and M-Audio Quattro problems.
Date: Wed, 22 Nov 2006 12:43:22 -0500
Message-ID: <45648C3A.3020402@inbox.ru>
References: <00d401c70e18$ae2c20c0$161ce4a0@supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <00d401c70e18$ae2c20c0$161ce4a0@supelec.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thibault Le Meur wrote:
> Your patch changes the AUDIOPHILE_* constant to MAUDIO_* constants. This is ok, but the Fast Track Pro patch submitted by "Peter Oehry" would need a trival rework to be applied.
> See the "snd-usb-audio - Driver for M-Audio Fast Track Pro" thread (August 2006) from Peter Oehry.
>   
Hmm, the old Audiophile and FastTrack discussions are fascinating 
reading. Seems like all M-Audio USB devices have the same or similar set 
of quirks and oddities that it's worth it to unify the approach to all 
of them.

Some observations:
1. All (please confirm for Audiophile) have some sort of 
usbaudio.sys-compatible functionality. In case of FastTrack it's a 
separate configuration, in case of Quattro it's a set of 2 streaming 
interfaces (#1 out, #2 in) within the single configuration. The 
"windows-compatible" pair of interfaces are *little-endian*, the rest 
are usually *big*endian* (except Quattro output interfaces which are 
little-endian). The windows-compatible interfaces only work with the 
first two channels, there's no windows-compatible interfaces for other 
two channels. This explains why the "default" driver setup 
(device_setup=0) gives the result of "2 channels little-endian, 
2-channels big-endian" (as I described in bug #2607) - the driver 
selects win-compatible interface for the first sub-device and the only 
available 16-bit interface for the second sub-device, and they are of 
different endianness. The device then locks itself into this useless state.
*Solution*: The win-compatible interfaces should be either completely 
ignored, or (if anyone ever needs them - maybe for some non-demanding 
applications that don't support big endian) made the ONLY available by 
the driver, perhaps with some module parameter. FastTrack seems to 
require additional quirks for that, or, looking from another angle, can 
provide an easier method of doing it completely in user space by writing 
a proper udev rule to select only the desired configuration.

2. All of these devices have 3 distinct operation analog modes: 16x11-48 
(all interfaces), 24x11-48 (2x4 or 4x2, bandwidth limitation) and 
24x88-96 (2x0 or 0x2). Some additional digital modes are also available 
for certain devices. Once a mode is chosen, it implicitly affects ALL 
interfaces - so choosing 16x48 for first device input and 24x48 for 
second output will NOT work. This is probably the reason why M-Audio 
chose to make two different (class-compliant and non-class-compliant) 
configurations for its devices, USB-Audio spec doesn't seem to define or 
permit such strict dependency between several interfaces, in the 
standard each interface is implied (or even defined? please correct me 
if I'm wrong) to be independent from others. So there's a need for the 
driver to explicitly forbid using incompatible interface altsettings.
*Current*solution* that is implemented: restrict the drivers to 
compatible list of altsettings upon load, specified by a module parameter.
*Limitations*:
 - Need to power-down and then power-up the device to change the mode. 
To overcome this, the device has to be set to "default state", by 
selecting "altsetting 0" for ALL interfaces, multiple times, but 
previous attempts to do this in Linux did not succeed.
 - Altsettings are chosen by their NUMBER, per device. Since altsetting 
numbers for each mode do NOT match among the devices, different set of 
quirks has to be implemented for each new (or old) device that needs 
support. Instead, the code should look at altsetting's data format and 
supported bit rates to decide if it should be included or not.
 - Need to reload the driver to select another mode. Once limitation 1 
is sorted out, there's a possibility of another approach - implement an 
ioctl (or other similar userspace-driven mechanism) to switch the device 
to another mode.

Plan of action:
1. Merge existing FastTrack and Quattro patches, leave quirks for the 3 
devices separate. *UPDATE*DOCUMENTATION*
2. Implement selecting either win-compatible or full mode.
3. Merge setting quirks for all devices by doing altsetting selection 
based on their inherent properties rather than number. When the user 
specifies a module parameter that is incompatible with the device (e.g. 
Digital output for Quattro), skip ALL altsettings.
4. Implement hot-reconfig.
5. Implement userspace mode selection (proc, ioctl,...). Might involve 
not "skipping" altsettings completely upon init, but rather making them 
"invisible" by some means, to be able to change the invisible flag to 
other altsettings later.

#1: I can do it easily, will send the patch later today.
#2 is already present in FastTrack patch, I can do it for Quattro and 
it's most likely the same for Audiophile but that needs verification.
#3 I can do partially, for analog altsettings only - Quattro doesn't 
have any digital interfaces.
#4:
> The windows driver only selects AltSettings 0 for all interfaces 
> "multiple times" before switching modes. I tried to implement this but 
> with no success. That's why I didn't included this in the first 
> Audiophile USB patch. However I'm still interrested in a way to do this. 
> I tried several patches in order to avoid this limitation (reset the 
> usb device, reset all interfaces to AltSet 0 several times before 
> re-setting them...) but nothing proved to be usefull for this issue.
Do you still have any of that code around? Can you send me an "attempt" 
patch so I can try it out locally? If not, can you point me to the 
existing code that sends "select altsetting zero" to the device?
I think I have an idea - and the keyword is to select altsetting-0 for 
"ALL interfaces", including the win-compatible ones! Anyway, this is 
worth playing around with.

#5: We need working #4 first, and then discuss the possible approaches.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
