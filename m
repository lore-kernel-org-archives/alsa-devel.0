From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: usb-audio
Date: Thu, 30 Oct 2003 13:42:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310301342.14872.bergtroll@gmx.li>
References: <20031027180300.GA5016@Zeryn> <200310292326.08018.bergtroll@gmx.li> <s5hsmlayl5r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmlayl5r.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 30. Oktober 2003 13:17 schrieb Takashi Iwai:
> At Wed, 29 Oct 2003 23:26:07 +0100,
>
> Niklas Werner wrote:
> > Am Mittwoch, 29. Oktober 2003 19:24 wurde geschrieben:
> > > At Tue, 28 Oct 2003 20:18:35 +0100,
> > >
> > >
> > > hmm, it seems that a wrong label is used.  the label should be
> > > conv_xx12_xx21 (= conv_labels[35]).  something is really broken.
> > >
> > > could you check stepwise the loop there?
> >
> > still checking (any tips on speeding this up (I'm trying "step 80000"
> > atm?), seems to happen after the first set of frames (=16384) is
> > processed.
>
> in the first process, did it go to conv_xx12_xx21 properly?

nope:

0x0fd422f4      184                             goto *conv;
(gdb) si
299     conv_1234_xx21: as_u16(dst) = bswap_16(as_u32c(src) >> 16); goto 
CONV_END;
(gdb) si
0x0fd424c0      299     conv_1234_xx21: as_u16(dst) = bswap_16
(as_u32c(src) >> 16); goto CONV_END;
(gdb) si
0x0fd424c4      299     conv_1234_xx21: as_u16(dst) = bswap_16
(as_u32c(src) >> 16); goto CONV_END;
(gdb) si
0x0fd424c8      299     conv_1234_xx21: as_u16(dst) = bswap_16
(as_u32c(src) >> 16); goto CONV_END;
(gdb) si
0x0fd424cc      299     conv_1234_xx21: as_u16(dst) = bswap_16
(as_u32c(src) >> 16); goto CONV_END;
(gdb) si
0x0fd4235c      230     conv_xxx1_xx10: as_u16(dst) = 
(u_int16_t)as_u8c(src) << 8; goto CONV_END;
(gdb) si
0x0fd42360      230     conv_xxx1_xx10: as_u16(dst) = 
(u_int16_t)as_u8c(src) << 8; goto CONV_END;
(gdb) si
190                             dst += dst_step;



Niklas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
