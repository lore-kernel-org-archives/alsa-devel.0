From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: dxs_support and via82xx (yet once more)
Date: Fri, 23 Apr 2004 12:56:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040423165625.MXVQ19268.smtp2.fuse.net@64BitBadass>
References: <s5h3c6vnfeg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h3c6vnfeg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > alias char-major-116 snd
> > alias char-major-14 soundcore
> > alias snd-card-0 via82xx
>                    ^^^^^^^
>                    snd-via82xx

Hmmm, but somewhere along the road while troubleshooting this/installing
something told me (a script) that I should drop the snd- prefix. Are you
saying that I still need snd- prefix? The alsa init does succeed after all
even with only via82xx (modprobing) so that's why I am asking.

> > #I tried every possible option
> > options via82xx dxs_support=1
> 
> this line is useless.

Because it's missing snd- prefix? (I removed the hdsp stuff from the
modules.conf for the better legibility but using cards without snd- prefix
seemed to work just fine, so I am guessing that snd- is needed for the
options call only, or am I misunderstanding this?)

> 
> > options snd-card-0 dxs_support=1
> > options snd-via82xx dxs_support=1

Shouldn't this then work?

> >
> > alias sound-slot-0 snd-card-0
> > alias sound-service-0-0 snd-mixer-oss
> > alias sound-service-0-1 snd-seq-oss
> > alias sound-service-0-3 snd-pcm-oss
> > alias sound-service-0-8 snd-seq-oss
> > alias sound-service-0-12 snd-pcm-oss
> >
> > Even with all this the syslog still complains:
> > via82xx: Assuming DXS channels with 48k fixed
> > sample rate.
> >          Please try dxs_support=1 or
> > dxs_support=4 option
> >          and report if it works on your machine.
> >
> > What am I doing wrong?
> 
> make sure that there is another defitions of snd-via82xx options in
> /etc/modules.conf or its variants.

I am sorry, not sure that I understood you here. Do I need to create alias
between via82xx and snd-via82xx or simply rename the card to snd-via82xx? If
I need to rename it, how come that it works even without snd- prefix (except
for the dxs option)?

Thank you very much for your help!

Best wishes,

Ico





-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
