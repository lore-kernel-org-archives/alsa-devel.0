From: David Lloyd <dmlloyd@tds.net>
Subject: Re: DMIX and capture stream
Date: Sun, 4 Jan 2004 18:02:11 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401041746270.12698@ultros>
References: <Pine.LNX.4.58.0401021421520.4466@tomservo.workpc.tds.net>
 <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
 <20040104145223.25bddac3.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040104145223.25bddac3.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 4 Jan 2004, Florian Schmidt wrote:

> On Sun, 04 Jan 2004 00:07:26 -0500
> Paul Davis <paul@linuxaudiosystems.com> wrote:
> 
> > >I'm working on changing DMIX to allow clients to open the capture
> > >stream.  
> > 
> > i don't get it. dmix is for playback, not capture. what would be the
> > semantics of this?
> 
> Hmm, i don't know the OP's answer to this, but i like to ask a very
> related question:
> 
> It is possible to create a playback pcm device with the help of the dmix
> plugin. This way several apps can playback at once - nice. But now what
> about using two apps that do full duplex at the same time?

This is exacly my point.  The fact that dmix and dsnoop are half-duplex is
where I have a problem.  There seems to be no way to allow more than one
OSS-compatibility client to share audio in a satisfactory way.  Which is
to say, you can have two doing playback, or two doing capture, or maybe
one each (haven't tried yet), but you can't do two full-duplex, or one
full-duplex and one capture or playback.  This is a bug in my opinion.  
It seems to me that this issue is not addressed by anyone, and that's why 
I started this code change, to allow capture to "pass through" so that one 
client can do full-duplex with multiple other clients still able to 
playback.  This is not too much to ask IMHO.

But at this point, I'm so disgusted I think I'll just buy a card with a 
hardware mixer like an SBLive, and forget about the whole thing.  It looks 
like the plugin mechanism is completely ignorant of full-duplex 
applications anyway.  I think that if a sound device doesn't have hardware 
mixing, it should be emulated in the kernel.  I know a lot of people don't 
thing that's as "clean" as using a plugin, but it would make the life of 
the end-user a lot nicer.

Have a nice day.

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
