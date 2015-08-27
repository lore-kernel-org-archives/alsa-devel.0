From: Rafael Gonzalez <ralfalfa@gmail.com>
Subject: Asus X553M audio issue SOLVED
Date: Wed, 26 Aug 2015 19:24:36 -0500
Message-ID: <55DE58C4.8050600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E888E2658EB
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 02:24:40 +0200 (CEST)
Received: by obbwr7 with SMTP id wr7so3260343obb.2
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 17:24:40 -0700 (PDT)
Received: from [192.168.169.59] (189-211-190-134.static.axtel.net.
 [189.211.190.134])
 by smtp.gmail.com with ESMTPSA id i3sm248222oig.24.2015.08.26.17.24.39
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2015 17:24:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guys, I was having a nice chat with debianuser from #alsa on freenode,
and he helped me fix my audio issues with my laptop that dual boots
windows and linux.

So, the easiest way to show you is post the log file of our conversation.

ud> Hi there.  You've been helping me with my card issues.
<salviadud> I want to share what progress I've got.
<salviadud> The machine is a dual boot laptop.
<salviadud> I also had another issue with ACPI, but I solved that by
turning D-Bus on
<salviadud> In fact, after d-bus, i can see the d-bus message when I
plug in my headphones to the jack.
<salviadud> I don't think that windows has been tampering with the
soundcard so that I need to do a full electrial reset on it.
<salviadud> I just think the alsa driver is ok, but there's something
missing.
<salviadud> I need to develop it, or something.
<salviadud> I want to know who should I talk to.
<salviadud> The card vendor (Realtek)
<salviadud> The laptop manufacturer (asus)
<salviadud> ?
<salviadud> If you got any ideas, I am all ears. so to speak
<salviadud> And my logic is this: there's no default option to choose
between headphones/headsets/speakers.  And like I said before, I can
only get audio on headphones with 3 ringed jacks.
<salviadud> Windows on the other hand, has this nifty userspace program
from realtek... I don't like crabs today.
<debianuser> Have you managed to boot any other linux liveusb on that
laptop? Ubuntu? Fedora? Mageia? Debian?
<salviadud> Funny that you mention that
<salviadud> I did try to load a kubuntu 14.10
<salviadud> but it hanged on me
<salviadud> Same thing happened with mint.
<salviadud> So, the other live cd I could load was a slax live usb stick.
<salviadud> But that one in particular loaded a different driver
<salviadud> and the sound that came out, was crackled.
<salviadud> I can still get sound on this thing, but it has to be from
external speakers, and hdmi out
<salviadud> Although, I think I need to play with hda analyzer for that.
<debianuser> I thought that internal speakers work fine, and you only
can't hear the sound from headphones...
<salviadud> Sorry
<salviadud> I meant what you just said
<salviadud> I called them external by mistake
<salviadud> laptop speakers work, headphones don't
<debianuser> Ah, ok :)
<salviadud> So, I want to be proactive about this
<salviadud> In what other way can I debug this
<salviadud> so that I can finally reverse engineer it
<salviadud> I think its an unusual thing to have a jack decide on what
to output based on the number of rings.
<salviadud> I guess I'm old.
<salviadud> I'm used to left-right jacks.
<salviadud> They are simple pieces of hardware
<salviadud> And well, I just love linux, I can't stand windows as my main.
<salviadud> Especially for music.
<debianuser> It's just there doesn't seem to be anything special about
your laptop or codec. It looks normal, but it behaves unusual, as when
your mixer values were different from codec dump...
<debianuser> Have you tried "full poweroff" by the way?
<salviadud> I haven't done it, I need to take out some screws for that.
<debianuser> What for?
<salviadud> The battery
<salviadud> Its not plug-n-play
<salviadud> its inside where the hdd lies
<debianuser> Ah, well, try just shut it down and unplug power supply,
without removing the battery
<debianuser> It's just has to be poweroff, not suspend, not hibernate...
<salviadud> I'm pretty sure I've done that.
<salviadud> start it up on just the battery.
<debianuser> (actually sometimes suspend or hibernate may help too, for
a different reason, but it's better to try poweroff first...)
<salviadud> I'll do it when I get off work
<salviadud> Still, getting ahead of it.  Lets say it stays the same.
<debianuser> The important part is not how you start it, but to power it
off for a few minutes, then boot linux first. You can boot it with power
supply attached, just boot linux first :)
<salviadud> mmmmm
<salviadud> Maybe its that
<salviadud> the missing link
<salviadud> I have never done that
<salviadud> after a certain time
<salviadud> windows doesn't allow me to access uefi
<salviadud> and it boots directly into windows
<salviadud> but
<salviadud> its because its the first option
<salviadud> I just need to change that
<salviadud> Ok, let me rephrase
<salviadud> If I shut down on linux
<salviadud> and I dunno, 10 minutes pass
<salviadud> I turn on my computer again, and I want to change my boot
option by pressing ESC.
<salviadud> I can't
<salviadud> It goes into fast boot mode
<salviadud> I can't control it
<salviadud> So, if I change my boot option
<salviadud> I should be able to do that.
<salviadud> Ok, please excuse my long explanation.
<debianuser> (it was reported to help for different laptops, including
laptops having the same codec: launchpad.net/bugs/1087428 comment 4)
<debianuser> How do you get to the linux then?
<debianuser> I mean how can you boot linux at all?
<salviadud> The first time was so hard.
<salviadud> I had to go into repair mode in windows.
<salviadud> So I could get into the bios.
<salviadud> After that, I could choose the cdrom option for boot
<salviadud> and that's how I installed it.
<salviadud> I don't use a boot manager like grub or lilo
<salviadud> just the Bios utility
<salviadud> so
<salviadud> I usually boot into windows first.  Then I do restart, and
then it allows me to select my different boot options
<salviadud> Its so annoying
<salviadud> I'm definetely changing the boot order
<debianuser> What if you select restart in windows, get into that
options list, and then just press the power button?
<salviadud> That link you gave me
<salviadud> same exact issue
<salviadud> Its too much of a hazzle
<salviadud> I want a permanent solution
<debianuser> What if you select restart in windows, get into that
options list, and then just press the power button - I mean does the
laptop turns off?
<salviadud> Yeah, it should
<salviadud> but when I turn it on, its gonna know it was powered off for
a while
<salviadud> and it will go into the first boot option
<salviadud> which is windows
<debianuser> Hm... Is there some hotkey to stop it? Maybe you need to
hold Ctrl or Alt?
<salviadud> Nope, its NSA loving spyware windows
<salviadud> what did you expect? hehehe
<salviadud> I know, its terrible
<debianuser> Is this the fastboot?:
https://www.asus.com/support/FAQ/1005535/
<salviadud> My bios does not look as fancy as that one
<salviadud> but yeah, that's the option.
<salviadud> I think I had to disable it just to get access to other boot
options
<salviadud> I think that bios might be for a desktop
<salviadud> I dunno, this laptop just feels really secure tight about
working on windows
<salviadud> and not on linux
<salviadud> I'll give it a go in a couple of hourse, I'll tell ya what
happened tomorrow
<salviadud> U are a lot of help dude, thank you much.
<debianuser> It's just its default setting. It may be useful for
windows, I mean regular users often don't need boot menu, but they want
OS to boot faster :) (I remember how people were impressed when I booted
simple linux gui in 10 seconds).
<salviadud> 10 seconds? that's still impressive, hehe
<salviadud> u know what, I'm gonna try this now
<salviadud> brb
<salviadud> dude, it totally worked
<salviadud> I'm listening to my tunes on audacious
<debianuser> Great! :)
<salviadud> as a token of my appreciation
<salviadud> here's my ftp server
<salviadud> anachronox.dyndns.za.org
<salviadud> user:ftpuser
<salviadud> pass:meridian2002
<salviadud> its full of music roms n pr0n
<salviadud> hehe
<debianuser> As for 10 seconds boot - it's just a generic kernel, with a
custom init script: about 5 seconds to probe/load modules for available
devices, 2 seconds for Xorg to start and switch to graphical mode, and 3
more seconds to boot firefox (I don't remember exact timings but
something like that).
<debianuser> There're better boot times on youtube:
https://youtu.be/whkmChncjRk   https://youtu.be/XcbKe3ct610
https://youtu.be/fMM-ZZijRc4  https://youtu.be/s7NxCM8ryF8  3-5 seconds
- that's impressive. :) But I was too lazy to build a custom kernel for
that. :)
<salviadud> I could do something similar...
<salviadud> I got a custom kernel
<salviadud> whatever... I don't care about boot times.
<salviadud> thanx again man.
<debianuser> You're welcome! Feel free to ask whenever you want to know
anything else :)
<salviadud> that ftp server gets shutdown when I got to sleep, keep that
in mind.
<salviadud> I turn it on, every now and then.
* debianuser saves a not that full poweroff makes sound headphones
working on a dual-boot Asus X553MA (Codec: Realtek ALC270)
<debianuser> *a note
<debianuser> And thanks for reporting the problem, by the way. If you
want to spend a few more minutes for it we can try to compare working
and broken settings to check what exactly was different... Maybe we find
a way to undo that...
<debianuser> (basically I'll just ask you to dump alsa-info 2 more times
with one special optio)
<debianuser> (and if we're lucky we'll have something to report to
alsa-devel mailing list, and devs would be able to include that into the
kernel to make it working in next kernel version out of box)
<salviadud> ok
<salviadud> sounds good
<salviadud> How do I run the script, headphones on or off?
<debianuser> There're vendor-specific coefficients that control the chip
but sometimes are not reset on reboot. To include those int alsa-info
run: `echo 1 | sudo tee /sys/module/snd_hda_codec/parameters/dump_coef`
then dump alsa-info as usual with headphones plugged in. That's the
"working" dump.
<debianuser> Then we'll break it: reboot into windows, reboot back into
linux, make sure headphones don't work, run `echo 1 | sudo tee
/sys/module/snd_hda_codec/parameters/dump_coef` and dump alsa-info with
headphones plugged in again. That would be "broken" dump.
<salviadud> ok, I don't sudo, so I'll just run that as root.
<debianuser> Then we'll diff them and see if there's some difference
that we can undo...
<salviadud> ok, working dump coming
<debianuser> yeah `echo 1 >
/sys/module/snd_hda_codec/parameters/dump_coef` as root will work too
<salviadud>
http://www.alsa-project.org/db/?f=abda2cd2c9137fbf2319015707cf2d8d30aaf773
<salviadud> I ran alsa-info after the echo
<salviadud> let me go back into windows..., and see if it breaks on reboot

* Registro cargado desde Wed Aug 26 18:45:41 2015

<salviadud> ok, I got broken audio
<debianuser> Now let's get broken alsa-info and diff them!
<salviadud>
http://www.alsa-project.org/db/?f=4d597f8a6f9eaa0f0823d195d5fa5093ea71d0eb
<salviadud> Well, I'm glad it worked
<salviadud> and hell, I even left windows as a special option
<salviadud> no need to erase boot options
<salviadud> I just disabled it so I can boot straight into linux
<salviadud> feels great man.
<debianuser> Hah! The difference is just in 2 coefficients: Coeff 0x04:
0x9827 (working) / 0x9027 (broken) and Coeff 0x0d: 0x4440 (working) /
0xc440 (broken)
<debianuser> Let's try to change them back and see if that would fix
headphones!
<salviadud> so, How do I do that?
<debianuser> To do that install "alsa-tools" package if you don't have
it yet and run these 4 commands in the following order:
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x04
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x9827
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x0d
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x4440
<salviadud> i got alsatools, let me give it a go.
<debianuser> (not sure what which one of them is doing, so let's set
them both and see if that will change anything)
<salviadud> I got sound
<salviadud> You are pro
<salviadud> although, I really wouldn't like to do that every time.
* salviadud knows that sounded dumb
<debianuser> Great! You don't have to do that every time (well, you can
add those to /etc/rc.local, or whatever is used in gentoo instead). But
the point was to find what was causing the issue.
<salviadud> that's why we're doing this test... hehe
<salviadud> Yeah, I think its a small, yet important contribution.
* debianuser wonders which one of those coefs breaks the sound...
<salviadud> I think its safe to just keep both like that.
<debianuser> Can you check that by the way? For example revert one of
them back to "broken" value and check if you still have the sound from
headphones:
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x04
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x9027
<salviadud> I will
<salviadud> for science
<salviadud> that broke it
<salviadud> I got no sound
<salviadud> What else do I do?
<salviadud> or is that it?
<debianuser> How about the other way around? 0x04 to working, 0x0d to
broken:
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x04
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x9827
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x0d
<debianuser>   sudo hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0xc440
<debianuser> (that's the last test)
<salviadud> it works
<salviadud> I think the other coefficient might be the hdmi
<salviadud> But I can't debug that one over here right now
<salviadud> still, that's just a wild guess
<salviadud> Well, you got all you need to report debugging info?
<debianuser> Well, that's all we need for the report. Now if you still
feel the power to make the world better (just a little bit) - you can
report that to alsa-devel mailing list. Include both alsa-info links,
tell which one of them works and which one has headphones broken after
windows reboot, and which hda-verb commands pair makes headphones
working again. :)
<salviadud> I'm just gonna send the log of this conversation
<debianuser> They may ask you to test a kernel patch (they often do
that) before sending it upstream to Linus. That's why it's better for
you to report it.
<salviadud> if you don't minnd
<debianuser> I don't :)
<salviadud> alsa rocks!
<debianuser> especially when it works :)
<salviadud> \O/
<debianuser> Thank you for your patience, for reporting the problem and
for doing all those checks!
