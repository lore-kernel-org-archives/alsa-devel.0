From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: IEC958 plugin and Rate plugin programming
Date: Mon, 13 Feb 2006 17:02:31 +0100
Message-ID: <20060213160231.GG9177@ifiu25.informatik.uni-halle.de>
References: <43EDAE9C.7060808@gmail.com>
 <20060213081740.GB8896@ifiu25.informatik.uni-halle.de>
 <43F0A236.8050604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43F0A236.8050604@gmail.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luca Piccioni <luca.piccioni@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luca Piccioni wrote:
> Clemens Ladisch wrote:
> > What is the actual problem?
> 
> Well... no sound!
> 
> So first I tried "aplay -Dhw:0,4" test.wav", but no sound. Then I've
> tried also "iec958" and "spdif", but nothing is outputted!
> 
> For the moment I haven't tried to use "iec958:0" as device because I
> don't have the amplifier to test audio.

":0" is the default anyway.

> Any suggestion to know if any PCM data is outputted to a particoular
> device?

Check with a device that has a SPDIF input that is known to work ...

> My soundcard is a Realtek ALC850 (reported by alsamixer), and I'm
> using the intel8x0 ALSA module. I'm also programming a multimedia
> application, so I've tried to use the snd_pcm_iec958_open... I thought
> this was the solution! :-/ As I've understood, this plug (iec958) it's
> used automatically when I setup i linear PCM to the spdif device?

No, AC'97 codecs generate SPDIF frames in hardware; the iec958 plugin
isn't needed.

> While I have to create this plug (programming) whenever the soundcard
> can't do this task?

The card-specific configuration files automatically use the iec958
plugin for the iec958 device when needed.

> what mixers I should enable to output to digital?

Those that are set when using the iec958 device; see at the end of
/usr/share/alsa/cards/ICH4.conf.

What is the output of "iecset"?


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
