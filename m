From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 16:59:08 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111165908.386c27c4.rpav@nwlink.com>
References: <20030111103010.2d9588cd.rpav@nwlink.com>
	<200301112332.h0BNW6X8017892@spider.tela.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301112332.h0BNW6X8017892@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Jan 2003 18:31:51 -0500
Paul Davis <paul@linuxaudiosystems.com> wrote:

<snip>
> not really. the mtpav is a "non-standard" device that uses special
> values in the datastream to switch its output port. the ALSA sequencer
> can't know this, and so it can't have any idea that strange things are
> happening at the hardware level.

That's what drivers are for. ;)  The ALSA sequencer shouldn't have to
know of course, but the driver should be able to handle it, and the
architecture should allow a working driver.

Nothing is "standard", anyway... I would contend that if the system
has to consider something "nonstandard" and treat is specially, when
it's just like any other device (pick a midi device at random), then the
system is wrong.

I do not believe, however, ALSA is this way.

> another example of this that i know a bit more about is on the
> tropez+. this has two MIDI output ports, and you can switch between
> them with 2 "unused" MIDI bytes. what should ALSA do if you deliver
> those bytes in a data stream? how can it know what they will do? why
> should it pay any attention at all to them?

It should pay attention because it's a universal sound architecture that
provides software from low-level driver to API.  The low-level driver
is all that needs to know about this.  The higher-level interface
probably does not.

I'm sure all this has been discussed before---I see evidence of it in
the very design and generalization of ALSA itself.  I can't imagine this
design is by accident.

-- 
Ryan Pavlik <rpav@users.sf.net>

"DEPLOY THE ROCKET BOAT!"


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
