From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: any support for realtech sound chip
Date: Thu, 22 Jan 2004 13:04:04 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074805444.13428.8.camel@moria.arnor.net>
References: <m3llnz25uf.fsf@ccs.covici.com>
	 <65072.138.88.11.209.1074802308.squirrel@cocula.com>
	 <401030A7.5050604@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <401030A7.5050604@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: "John W. Cocula" <john@cocula.com>, John Covici <covici@ccs.covici.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I've got an ABit MAX-3 with the ALC650 chip controlled by the Intel ICH5
(R) as well.  Playback through the front channel with ALSA works fine.

My problem is that the motherboard has 5 1/8th inch mini jacks on the
back, and two of those can be configured as either input or output. 
One may be either Microphone 1 stereo input, or output the center
channel and subwoofer channel.  Another may be either a stereo line
input, or output the rear surround channels.

The gnome ALSA Mixer program shows options to set these (they appear as
check boxes labelled "Line-In As Surround" and "Mic As Center/LFE") but
selecting them doesn't seem to give me any extra output channels.

With both of those checkboxes turned on, my /proc/asound/devices still
shows:

[thoffman@moria thoffman]$ cat /proc/asound/devices
  0: [0- 0]: ctl
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

(Device 0-4 is the optical SPDIF output.  I don't know if it works or
not, I have nothing that can take optical inputs.)

If anyone out there knows how to make my six-channel sound outputs
actually work, I'd be deeply appreciative.

Thanks!


On Thu, 2004-01-22 at 12:20, James Courtier-Dutton wrote:
> 5.1 Audio works fine on my ALC650 rev 3 chip.
> I have a Intel ICH5 chip controlling it.
> Try my speaker-test program from 
> http://www.superbug.demon.co.uk/speaker-test/
> 
> Cheers
> James
> 
> 
> John W. Cocula wrote:
> > The Realtek ALC650 rev 3 chip, in my Shuttle SB62G2, is supported by the
> > intel8x0 driver.
> > 
> > HOWEVER, and I have a headache from it at this very moment, I've just
> > learned that the driver does not support anything but the front L and R
> > channels for output.
> > 
> > Can anyone tell me what is involved in evolving the driver so that it will
> > support all 6 playback channels?  Please someone tell me what I can do to
> > help make this come to pass!
> > 
> > Many thanks,
> > John
> > 
> > Now to find some ibuprofen.
> > 
> > 
> > John Covici said:
> > 
> >>Hi.  I would like to use a Shuttle An50R which supports the Athlon 64
> >>under Linux, but their sound chip is an ac97 audio Realtech.  What
> >>module would support such a beast or is it not possible to use ALSA
> >>with that chip?
> >>
> >>Thanks.
> >>
> >>--
> >>         John Covici
> >>         covici@ccs.covici.com
> >>
> 
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
