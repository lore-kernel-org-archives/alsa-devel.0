From: Mark Knecht <markknecht@comcast.net>
Subject: Re: After warm boot Alsa not detecting sound card
Date: Mon, 03 Nov 2003 16:46:38 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067906797.1831.9.camel@Wizard.knechthome.com>
References: <1067832822.2011.8.camel@Wizard.knechthome.com>
	 <1067893471.24188.135.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1067893471.24188.135.camel@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Fernando,
   Thanks for the response. I have blacklisted the usb-midi and audio
drivers and they no longer load. as expected. 

   I discovered this afternoon that I have too much stuff in
modules.conf I think. (Actually in /etc/modules.d/alsa) 


# OSS/Free portion - card #1 (HDSP9652)
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# OSS/Free portion - card #2 (MidiSport 2x2)
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss


alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss


Shouldn't I remove some of the services for card #2? (The MidiSport) The
PlanetCCRMA Nano Config guide doesn't seem to show which of these 5
aliases should be used. (If any!) Can you help? I'll try removing the
mixer and pcm-oss ones, and I'll try keeping the seq-oss ones, however
all of that is just OSS support, correct? Running Alsa apps, do I care
at all about OSS support for the MidiSport? I'm thinking no, and that
maybe all 5 lines can be removed?


On Mon, 2003-11-03 at 13:04, Fernando Pablo Lopez-Lezcano wrote:

> The following two are the oss usb modules, you should blacklist them in
> /etc/hotplug/blacklist so that only the alsa modules are loaded. 
> 
> > usb-midi               17180   0  (unused)
> > audio                  41400   0  (unused)
> 
<SNIP>
> This is, I think, a problem with the stock alsasound script. It does not take into
> account that other stuff may start alsa subsystems before the alsasound script
> runs. 
> 
> In this case hotplug loads the alsa usb driver. A while later alsasound is
> executed but it tests for /proc/asound to determine if it is "already running",
> that test is true and the rest of the alsa modules are not started. 
> 
> If this is (as I suspect) in your Gentoo box you could try copying the hacks
> I made to the Planet CCRMA alsasound script so that it loads anything that has
> not been loaded so far. That should fix the problem. 
> 

I will take a close look at that script on my Planet box soon and see if
I can scope out what you did. Thanks for the pointer.

With best regards,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
