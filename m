From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: General Guidelines?  (MIDI)
Date: Mon, 13 Jan 2003 10:25:55 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301131008290.5715-100000@studcom.urz.uni-halle.de>
References: <20030111183121.GA12653@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030111183121.GA12653@bhv1.adelphia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Victor <bhv1@psu.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Brian Victor wrote:
> Are there any documented guidelines on how to make use of ALSA
> (especially MIDI) functions?

This is one of the parts still missing from the documentation.

Well, there are example programs ...

> For example, when using ALSA data type foo, the standard seems to be to
> call snd_seq_alloc_foo, manipulate foo as desired, then call
> snd_seq_free_foo.  This is easy enough, but sometimes (as in the case of
> queue), there is also a create function; how does this differ from
> alloc, and is it necessary?

The data type holds properties of the object, but it's only used to
communicate between the application and the ALSA library. The create
function creates the actual object in the kernel.

> Also, what is the relationship between buffers and queues?

Buffers are used to send or receive events to/from the kernel sequencer,
which is responsible for routing them to/from other clients. It's an
internal optimization; usually, you don't have to care about them.

Queues are used to connect two ports and to schedule events to be sent at
a specific time. This can be used to play MIDI files (see
alsa-lib/test/playmidi1).


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
