From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Thu, 26 Sep 2002 09:47:50 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209260943040.4746-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.31.0209252301320.29794-100000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.31.0209252301320.29794-100000@lorien.wv.mentorg.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "Pikus, Fedor" <fedor_pikus@mentorg.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> On Wed, 25 Sep 2002, Takashi Iwai wrote:
> > At Tue, 24 Sep 2002 20:03:54 -0700 (PDT),
> > Fedor G. Pikus <fedorp@wv.mentorg.com> wrote:
> > >
> > > > then the complete callback is called properly but likely
> > > > snd_pcm_period_elapsed() is not called.
> > >
> > > That's right, it's not called:
> > > for (i = 0; i < urb->number_of_packets; i++) {
> > >         cp = (unsigned char *)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
> > >         if (urb->iso_frame_desc[i].status) /* active? hmm, skip this */
> > >                 continue;
> >
> > could you check what value is stored in the status field?
> > i guess some negative value, which represents an error.
> Always -75.

-75 = -EOVERFLOW = babble

I think this indicates that the device sends more data than the driver
expects. Probably the transfer buffer size is calculated for some lower
sample rate?


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
