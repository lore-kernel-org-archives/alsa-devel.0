From: Torrey Hoffman <thoffman@arnor.net>
Subject: Multichannel AC97 support - was "Re: any support for
	realtech sound chip"
Date: Fri, 23 Jan 2004 10:31:25 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074882685.13428.88.camel@moria.arnor.net>
References: <Pine.HPX.4.33n.0401231051090.5910-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0401231051090.5910-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "John W. Cocula" <john@cocula.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-01-23 at 01:52, Clemens Ladisch wrote:
> John W. Cocula wrote:
> > $ ./speaker-test -Drear -c 2
> >
> > ALSA lib pcm.c:1812:(snd_pcm_open_conf) Invalid type for PCM rear definition (id: rear, value: cards.pcm.rear)
> > Playback open error: Invalid argument
> 
> You cannot access the rear channels seperately (at least not
> directly). The ICH only supports 2-channel (front), 4-channel
> (front+surround) and 6-channel (front+surr+center+lfe) output.

This is interesting... If I understand you correctly, you mean that the
digital PCM data for the 4 channels or 6 channels must all be
interleaved together and sent through a single device, just like the
left and right channels of a stereo channel?

If this is correct, would it be possible to set up a plug-in layer which
opens the ICH hardware in 6-channel mode, but then provides three
virtual stereo devices to applications?  

The plugin would just interleave, or multiplex the digital pcm data
together, and insert silent "0" samples on any channel which wasn't
opened by an application.

Diagram:  (each letter represents a 16-bit PCM sample)

pcm stereo 1: ababab... -->  |========|                      |hardware|
pcm stereo 2: cdcdcd... -->  | plugin |-->abcdefabcdef... -->|in 6 ch |
pcm stereo 3: efefef... -->  |========|                      | mode   |

My goal is to get my ICH-->realtech working in 6 channel output mode in
a way that I can run three instances of Rhythmbox, streaming three
totally independent stereo streams to three stereo amplifiers hooked to
speakers in three different rooms :-)

Hopefully this is not impossible?  

I'm willing to do some programming to make it happen, if the hardware
can support it...

Torrey

> 
> 
> HTH
> Clemens
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
