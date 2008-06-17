From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Re:
	=?iso-8859-1?q?hda-intel_on_Asus_M2N-X_Plus_NVIDIA_G?=
	=?iso-8859-1?q?eForce=096100/nForce_430_mobo?=
Date: Tue, 17 Jun 2008 18:17:03 +0200
Message-ID: <200806171817.03604.cave.dnb2m97pp@aliceadsl.fr>
References: <200806162000.02321.cave.dnb2m97pp@aliceadsl.fr>
	<4856B078.1000002@cox.net>
	<200806162054.12813.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 2820524512
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 18:17:18 +0200 (CEST)
In-Reply-To: <200806162054.12813.cave.dnb2m97pp@aliceadsl.fr>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-user@lists.sourceforge.net, stan <ghjeold_i_mwee@cox.net>
List-Id: alsa-devel@alsa-project.org

I've CC'd the Alsa-user list on this reply, in case it's usefull to those that 
arn't subscribed to Alsa-devel.

Anyway sound problem resolved, as below.

On Monday 16 June 2008 20:54, Nigel Henry wrote:
> On Monday 16 June 2008 20:27, stan wrote:
> > Nigel Henry wrote:
> > > I've just built a new machine, and expected problems with the onboard
> > > soundcard, and also have problems with the onboard NIC, but that's
> > > another problem, which is resolved by installing my last remaining
> > > realtek 8139 PCI card.
> >
> > Is the sound device enabled in BIOS?  And I'm surprised that your NIC
> > isn't working.  Those are
> > almost generic these days.
>
> Hi Stan. I don't want to check the BIOS at the mo, as I'm DL'ing a load of
> updates for F8 on this machine, but I'm pretty sure that the sounds are
> enabled. I wil check this though.
>
> I googled a bit for the NIC problem with the MCP61 chipset, and did see
> someones lspci listing Ethernet against a MCP61 entry, but I have no such
> entry. Anyway, a possible fix for the sounds would be nice.
>
> > > Anyway the mobo is an Asus M2N-X Plus NVIDIA GeForce 6100/nForce 430,
> > > and the Southbridge (which appears to handle allsorts of stuff) is
> > > MCP61.
> > >
> > > the specs for the soundcard from the Asus site are below.
> > > ALC662 6-Channel High Definition Audio Azalia CODEC
> > > Support Jack-Sensing, Enumeration, Multi-streaming
> > > S/PDIF out on back I/O port
> >
> > Did a search in the driver source and the azalia is mentioned in the
> > hda-intel.c module.  Using hg snapshot of 20080520.
> >
> > > This is using the Fedora 8 distro, which has alsa driver 1.0.15, and is
> > > probably a bit old.
> >
> > Yeah, probably a good idea to upgrade this.  Did you notice that
> > jaroslav had just posted the 1.0.17rc2 link?
>
> Yes I saw that. When the updates for F8 have finished, I'll DL, and install
> the latest driver
>
> > http://www.alsa-project.org/main/index.php/Changes_v1.0.17rc1_v1.0.17rc2
> >
> > > The card is not detected at bootup, but I did a modprobe snd-hda-intel,
> > > using various model options. the modules were loaded, but a cat
> > > /proc/asound/cards showed "no soundcards detected"
> >
> > If you do a search in the dmesg output for intel or hda or snd or alsa
> > or azalia does anything turn up?
>
> Don't get anything from any of them, just returned to the command prompt
> I've run the alsa-info.sh script, and
> > > the link is below.
> > >
> > > http://pastebin.ca/1048647
> >
> > The modules showing here are not from bootup, but are manually installed?
>
> Yes. lsmod had no alsa stuff loaded after bootup. I modprobed
> snd-hda-intel, and the alsa modules were loaded, but cat /proc/asound/cards
> showed "no soundcards"

> > > Thanks for all your work you folks.
> > >
> > > Nigel.

Update, with sounds now working.

To set the scene, I installed F8 on this new machine that I'd built, and it 
installed ok (caveat: I had to disable ACPI in the BIOS, otherwise I couldn't 
boot any install disc, or live CD). The kernel that was installed is 
2.6.23.1-42.fc8, using Alsa driver 1.0.15 IIRC. Neither the soundcard, or the 
onboard Ethernet card were detected. As I wanted to do the updates for F8, I 
went into the BIOS, and disabled the onboard NIC, and as it turns out, also 
disabled the Azalia audio. Installed the Realtek 8139 PCI NIC, and the 
network is now working.

I now took the machine upstairs, so as to be able to plug it into my Ethernet 
switch, booted up, and logged into Gnome. I don't use Gnome, but logging into 
KDE resulted in a dead mouse, and keyboard, and needed a hard reset to exit 
KDE, and then reboot. I think there was a problem, either with just the 
2.6.23 kernel, or perhaps also with other needed updates, which caused F8 
post install to not play well with this Asus M2N-X Plus mobo.

Ok this is as far as I got with my last reply, as I was downloading the 
updates. Updates now installed, and now have kernel 2.6.25.4-10.fc8, and Alsa 
driver 1.0.16rc2.

Reboot with the new kernel, login to KDE which now is ok, but still no sound, 
and nothing in /proc/asound/cards. Reboot, and check the Azalia setting in 
the BIOS, and yes, I'd forgotten that I'd disabled it. Set it to auto, then 
boot up. Miracle of miracles, the sound now works.

I must admit, that having tried to help out on various lists with hda intel 
problems, I was probably a bit paranoid, and didn't seriously expect the hda 
intel card to work on this machine. Speaker-test only outputs on left front. 
KDE's sound test plays ok. An audio CD wouldn't output any sound, until I 
realised that I hadn't been able to find an analogue audio cable for the 
optical drive. Changing a setting to direct digital output fixed that 
problem.

I'd already removed the alsa-plugins-pulseaudio package, as I had problems 
with pulseaudio on my other F8 install. Alsamixer doesn't show many sliders, 
but I think that is normal with hda intel cards, compared to my Audigy2 
soundblaster one, which has sliders for everything under the sun.

I may try some of the model options for the hda intel card, but it seems to be 
producing sounds ok with the default. Speaker-test just trying left front is 
strange though.

Anyway sounds work, and I rebooted, entered the BIOS, and re-enabled the 
onboard NIC, which is now detected ok. I think that the later 2.6.25 kernel, 
along with all the other updates were needed to get F8 to work well with this 
mobo.

I havn't updated the alsa driver to the latest, as the sounds appear to be 
working ok, but as there is a whole bunch of freespace on this harddrive, I 
may install another instance of F8, and update the alsa driver to see if 
there are any differences. I've re-run the alsa-info.sh script with sounds 
now working, and the link is below.
http://pastebin.ca/1049215

Thanks Stan, and all you other folks at Alsa-devel who are working on 
resolving Alsa driver problems.

Nigel.
