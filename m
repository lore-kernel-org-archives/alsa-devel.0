From: Peter Toye <alsa@ptoye.com>
Subject: Re: Newbie question - cannot get sound to work in Ubuntu
Date: Fri, 7 Mar 2008 21:59:53 +0000
Message-ID: <1067293091.20080307215953@ptoye.com>
References: <909985268.20080229192431@ptoye.com>
	<200803041943.43308.cave.dnb2m97pp@aliceadsl.fr>
	<275732031.20080305224831@ptoye.com>
	<200803071615.11398.cave.dnb2m97pp@aliceadsl.fr>
Reply-To: Peter Toye <alsa@ptoye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <200803071615.11398.cave.dnb2m97pp@aliceadsl.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Friday, March 7, 2008, 3:15:11 PM, you wrote:

> On Wednesday 05 March 2008 23:48, Peter Toye wrote:
>> Nigel,
>>
>> Thanks. My comments are below.
>>
>> Best regards,
>>
>> Peter
>> mailto:alsa@ptoye.com
>> www.ptoye.com
>>
>> -------------------------
>>
>> Tuesday, March 4, 2008, 6:43:43 PM, you wrote:
>> > Hi Peter. I've spent most of the afternoon (as I have nothing better to
>> > do) googling your problem, and there are a few things you can try. First
>> > though, do you have a live cd of Gutsy Gibbon, or Knoppix that you can
>> > bootup with, and see if you have the sounds working?
>>
>> That's very kind of you to take so much time.
>>
>> I booted up from a live Gutsy Gibbon CD (the one I used to create my
>> system) and it's quite interesting. Typing "alsamixer" in a terminal
>> session brings up the mixer OK! But with a seriously confusing set of
>> controls, only some of which seem to have much connection with the sound
>> card. And the "line in" column in the "capture" view doesn't have a fader
>> associated, which seems a bit odd. Maybe there's something I don't
>> understand here.
>>
>> And I can use the GNOME utilities to record and play back. Didn't have time
>> to try the command-line versions. Won't have time until Friday at the
>> earliest.
>>
>> > Now moving on to my googling stuff.

>> lspci -v output:
>> 00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
>> 07) Subsystem: Creative Labs CT4830 SBLive! Value
>>         Flags: bus master, medium devsel, latency 64, IRQ 10
>>         I/O ports at d400 [size=32]
>>         Capabilities: [dc] Power Management version 1
>>
>> 00:0b.1 Input device controller: Creative Labs SB Live! Game Port (rev 07)
>>         Subsystem: Creative Labs Gameport Joystick
>>         Flags: bus master, medium devsel, latency 64
>>         I/O ports at dc00 [size=8]
>>         Capabilities: [dc] Power Management version 1

>> > Alsamixer when opened shows the default card (card0), but have a look at
>> > the manpages for alsamixer. I now open these in a webbrowser as
>> > man:alsamixer. To start alsamixer for other cards you have the -c option.
>> > For example, alsamixer -c0  brings up the default cards mixer settings.
>> > alsamixer -c1 brings up the mixer settings for card 1, and so on.
>>
>> If I type alsamixer -c0 the mixer comes up with the same options as the CD
>> boot (see above). I thought that -c0 was the default, but it doesn't seem
>> to be.

> Hi Peter. It's getting a bit surreal now, as typing alsamixer, is ( under 
> normal circumstances)  the same as typing alsamixer -c0. For the sake of 
> those on the alsa-devel list I've put the error you get when just typing 
> alsamixer as user below.
> Typing "alsamixer" in a terminal window gives:
> "alsamixer: function snd_ctl_open failed for default: No such device"
> Whereas typing alsamixer -c0 opens alsamixer.

> At least you have access to the mixer settings now, although you say that some 
> of the controls appear to be a bit bizarre.
Well, I'll start examining them in details when there's time. One problem
is that there doesn't seem to be room on the screen for all the controls!

> Would you download this script from:
> http://hg.alsa-project.org/alsa/raw-file/tip/alsa-info.sh
Have done (on my email machine and transferred via a USB stick).

> There are a bunch of options now available for the script, so after making it 
> executable, run it as user as below.
> ./alsa-info.sh --with-amixer --with-alsactl --with-configs

> The script will trawl out a bunch of stuff about your sounds, and upload it to 
> pastebin. Just post back the link to the pastebin site when you reply.
Aaahh. This is more complex. As I said, it's not connected to the Internet
- I'll have to steal my router back. And I doubt if this can happen before
tomorrow at the earliest, and more likely Monday.

> Not sure about an easy Alsa guide.
I found this http://www.sabi.co.uk/Notes/linuxSoundALSA.html and have been
looking at it. One thing interested me: it says that there should be a
directory: /proc/asound/dev/
 the directory containing device files.  device files are created
 dynamically; in the case without devfs, this directory is usually
 linked to /dev/snd/

I don't have this directory. But trying to create it by

cd /proc
sudo chmod u+w asound
cd asound
sudo ln -s /dev/snd dev

results in
ln: creating symbolic link `dev' to `/dev/snd': No such file or directory

I'm a bit rusty on Unix commands, but /dev/snd is definitely there. So I
can't work out why I can't construct the link. Even if it's needed. Not
that this has anything to do with ALSA of course.

> All the best.

> Nigel.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
