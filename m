From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Multichannel AC97 support - was "Re: any support
 for realtech sound chip"
Date: Fri, 23 Jan 2004 20:01:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401232001100.17082@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0401231051090.5910-100000@studcom.urz.uni-halle.de>
 <1074882685.13428.88.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074882685.13428.88.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, "John W. Cocula" <john@cocula.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Jan 2004, Torrey Hoffman wrote:

> On Fri, 2004-01-23 at 01:52, Clemens Ladisch wrote:
> > John W. Cocula wrote:
> > > $ ./speaker-test -Drear -c 2
> > >
> > > ALSA lib pcm.c:1812:(snd_pcm_open_conf) Invalid type for PCM rear definition (id: rear, value: cards.pcm.rear)
> > > Playback open error: Invalid argument
> > 
> > You cannot access the rear channels seperately (at least not
> > directly). The ICH only supports 2-channel (front), 4-channel
> > (front+surround) and 6-channel (front+surr+center+lfe) output.
> 
> This is interesting... If I understand you correctly, you mean that the
> digital PCM data for the 4 channels or 6 channels must all be
> interleaved together and sent through a single device, just like the
> left and right channels of a stereo channel?
> 
> If this is correct, would it be possible to set up a plug-in layer which
> opens the ICH hardware in 6-channel mode, but then provides three
> virtual stereo devices to applications?  
> 
> The plugin would just interleave, or multiplex the digital pcm data
> together, and insert silent "0" samples on any channel which wasn't
> opened by an application.
> 
> Diagram:  (each letter represents a 16-bit PCM sample)
> 
> pcm stereo 1: ababab... -->  |========|                      |hardware|
> pcm stereo 2: cdcdcd... -->  | plugin |-->abcdefabcdef... -->|in 6 ch |
> pcm stereo 3: efefef... -->  |========|                      | mode   |
> 
> My goal is to get my ICH-->realtech working in 6 channel output mode in
> a way that I can run three instances of Rhythmbox, streaming three
> totally independent stereo streams to three stereo amplifiers hooked to
> speakers in three different rooms :-)
> 
> Hopefully this is not impossible?  

No, use the dshare plugin with different channel bindings.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
