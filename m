From: Manush Dodunekov <manush@stendahls.net>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Thu, 2 May 2002 11:00:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.40.0205021054250.2221-100000@dunk.hq.fett.net>
References: <200205020327.g423RZD24293@post2.fast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205020327.g423RZD24293@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Martijn Sipkema <msipkema@sipkema-digital.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 1 May 2002, Paul Davis wrote:

> >This looks nice. Do rawmidi ports created this way appear as sequencer
> >clients as well?
>
> it depends. there is a module that looks at all current rawmidi ports
> and makes them available as sequencer clients. just creating a rawmidi
> device doesn't do this by itself.

Ok.

> i wanted to add, for clarification:
>
> when snd_{pcm,rawmidi}_open() sets up the function pointers for the
> relevant device type, obviously the standard types use functions that
> make calls to the ALSA device drivers. but you can define non-standard
> types that don't do this. so you can relatively easily write an ALSA
> MIDI user-space driver, for example, that interacts with the standard
> serial driver, or with a generic ieee1394 driver or a generic usb
> driver. rather than make ioctls/read/write calls on an ALSA device,
> your code would operate on "/dev/some/other/driver's/inodes".

Ok. I'll give a userspace unitor8-driver a try then.

-- 
Manush


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
