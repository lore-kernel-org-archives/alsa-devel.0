From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Configuring the mixer
Date: Fri, 23 Apr 2004 18:03:15 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404231756440.1891-100000@studcom.urz.uni-halle.de>
References: <017iDVVMe5392S06.1082669884@cmsweb06.cms.usa.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <017iDVVMe5392S06.1082669884@cmsweb06.cms.usa.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nikhil Deo <nikhil_deo@usa.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nikhil Deo wrote:
> It is to be done on QNX

By now, QNX's API is completely different.

> I need to capture input from the mic AND the line in.

This will work only if your hardware supports this.  Many sound cards
can select exactly one input for recording.

> Then I need to output the mic input on the Right-LineOut and
> leftLineIn on leftLineOut. (right line in can be ignored)

This is easy once you have captured the data.


Another possibility would be to configure the mixer to route the
inputs as you want them.  Again, this is dependent on the capabilities
of your hardware/drivers.

> in 2, my mixer group was input gain and although it seemed to be recording
> something, I could not figure out what it was. How do I make it take the input
> from  mic in only?

In ALSA, most cards have a mixer control "Capture Source" which allows
to select between several input.  Some cards have "Capture Volume"
controls for each input and mix all together.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
