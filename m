From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: example of sending note on/off to MIDI port
	(Timidity's virtual sequencer)
Date: Thu, 20 Oct 2005 19:17:35 -0400
Message-ID: <1129850256.7918.6.camel@mindpipe>
References: <4358068C.3050405@dccnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4358068C.3050405@dccnet.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brolin Empey <f7@dccnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-10-20 at 14:05 -0700, Brolin Empey wrote:
> Hello,
> 
> I want to add ALSA support to a MIDI program I wrote (in C) which 
> currently supports only the Win32 API (using midiOutShortMsg).  More 
> specifically, I want to do this using Timidity's virtual sequencer for 
> playback of the output MIDI messages.  I can use playmidi (which uses 
> the OSS API) or pmidi (which uses ALSA's API) to play MIDI files using 
> Timidity's port (128:0).  After studying both of these application's 
> sources, I tried without success to put together a minimal test program 
> to simply send a note on and subsequent note off message using 
> Timidity's port.
> 
> Does anyone have a simple example of how to do this?  It can use either 
> the OSS API (e.g. /dev/sequencer interface) or ALSA's library.  I tried 
> the rawmidi example, but could not get it to play anything using 
> Timidity's port.

You forgot to include a link to your code.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
