From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: DMIX and capture stream
Date: Sun, 4 Jan 2004 14:52:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040104145223.25bddac3.mista.tapas@gmx.net>
References: <Pine.LNX.4.58.0401021421520.4466@tomservo.workpc.tds.net>
	<200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: dmlloyd@tds.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 04 Jan 2004 00:07:26 -0500
Paul Davis <paul@linuxaudiosystems.com> wrote:

> >I'm working on changing DMIX to allow clients to open the capture
> >stream.  
> 
> i don't get it. dmix is for playback, not capture. what would be the
> semantics of this?

Hmm, i don't know the OP's answer to this, but i like to ask a very
related question:

It is possible to create a playback pcm device with the help of the dmix
plugin. This way several apps can playback at once - nice. But now what
about using two apps that do full duplex at the same time?

It is also possible to create a readable pcm device with the help of the
dsnoop plugin. This way several apps can record at once..

But the question is: How do i combine those two, so that i have a pcm
device that is readable and writeable by multiple clients on a soundcard
that does not support hw mixing of neither capture nor playback streams.
And how do i get OSS emu to work with it. I suppose i will need to alter
the pcm.dsp0 device to use that dmix/dsnoop combined device..

Flo

-- 
music: http://www.soundclick.com/bands/9/florianschmidt.htm




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
