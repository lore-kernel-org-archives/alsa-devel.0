From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Midisport 2x2 spawns before Alsa, taking the
	device0 slot event though modules.conf puts snd-usb-midi as 3rd device ->
	result potential hardlocks when opening dsp
Date: 25 Feb 2003 17:55:46 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046224546.31802.101.camel@cmn37.Stanford.EDU>
References: <000001c2dd25$3d7d5e70$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000001c2dd25$3d7d5e70$aa1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I was just wondering how can I force snd-usb-midi to assume device 2
> slot, rather than the default 0 when spawning, since at boot time on my
> machine USB gets initialized before alsa and therefore if I have
> Midisport 2x2 hooked up, it ends up being my default /dev/dsp device
> (which actually does not exist) and that makes apps like pd hardlock my
> machine if trying to access them.
> 
> So my question is twofold:
> 
> 1) Is there anything I can configure about my boot process, where Alsa
> gets initialized before USB (I am assuming not, since Alsa does not
> start until someone logs in, please correct me if I am wrong).

Alsa is started (in the configurations I've seen) as a service and that
happens at boot time if the alsasound service is started (how that is
configured depends on the distro - redhat uses the chkconfig program).
If sound is only loaded when you are logging in then the alsasound
script is not being executed on startup. 

You could blacklist the usb audio related modules so that they are
started latter in the boot process by the alsasound script (just add
usb-midi, audio and snd-usb-audio to /etc/hotplug/blacklist). 

> 2) Is there anything I can specify in my modules.conf or elsewhere in
> order to force the device to be used as snd-card-2 and not snd-card-0 (1
> I would like to reserve for hdsp).

alias snd-card-1 snd-usb-audio
alias sound-slot-1 snd-card-1

and then...
options snd-usb-audio index=1

this assumes "cards_limit=2" in "options snd"
-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
