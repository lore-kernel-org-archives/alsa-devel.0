From: Stephane Alnet <alsa-dev@shimaore.net>
Subject: Re: Re: snd-usb-audio: quirk for Edirol UA-5 in Advanced
 Mode
Date: Thu, 12 Jun 2003 14:13:38 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306121358040.9849-101000@kani-keli.alnet.home>
References: <Pine.HPX.4.33n.0306120954450.13924-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1487233806-1055445218=:9849"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306120954450.13924-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1487233806-1055445218=:9849
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 12 Jun 2003, Clemens Ladisch wrote:
> I didn't see your first post (maybe because the current list moderator
> is Dave Null),

OK, so I won't feel bad sending the diff a second time, then. :)

> so I'm only guessing what your diff did.
>
[...]
> > > When in Advanced Mode, the UA-5 exposes all its interfaces in class
> > > 255/255 (Vendor/Vendor), but actually besides this all the
> > > descriptors are valid USB Audio control/interfaces/endpoints/...
[...]
> There already is a quirk type for this, QUIRK_STANDARD_INTERFACE. See
> the quirk entry for the UA-20, which behaves in the same way (the
> UA-20's interface #3 is for the MIDI ports).

That's what I hoped too (didn't want to have to change usbaudio.c if at
all possible) but it didn't seem to work. (My understanding is that
STANDARD_INTERFACE needs at least the bInterfaceSubClass info to be valid.
This isn't the case on the UA-5.)

Here's the interesting part of the quirk I proposed (mostly a rewrite of
STANDARD_INTERFACE that goes blindly trusting what usbquirks.h says):

  for( i = 0; i < iface->num_altsetting; i++ )
  {
    alts = &iface->altsetting[i];
    altsd = get_iface_desc(alts);
    altsd->bInterfaceClass = USB_CLASS_AUDIO;
    altsd->bInterfaceSubClass = USB_SUBCLASS_AUDIO_STREAMING;
  }

[I'm not sure the overwrite of Vendor with USB_CLASS_AUDIO is strictly
required, but it didn't hurt and is consistent with changing the
subclass.]

Of course since it's my first time looking at alsa/kernel, I may just be
plain off-track. :)
S.

---1463811839-1487233806-1055445218=:9849
Content-Type: APPLICATION/octet-stream; name="ua5.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0306121413380.9849@kani-keli.alnet.home>
Content-Description: 
Content-Disposition: attachment; filename="ua5.diff.gz"

H4sICFuq5j4AA3VhNS5kaWZmAK1W4XLaRhD+DU+xdacZMAgEGDvGicfEKC2T
BKdgd9JJM5pDdzI3Fid6kpykGb97d+8kI2zsOtNoxki+2/12b/fbveUyDMHJ
NERSZV+cbqvfOnCd+VVnr53EmeLtLJnTH8u4jFvBfTEnY/2tolXHcZ6IWum6
bs9x952OC93uoN8Z9Pott3jAcfuuW200Gt9hfQOyN3B7g273HuTJCTjdvU6n
uQ8N897rwslJFSpapJlW4B5V4aYK1UZ7t9qAXQi0YKkABkmKX0sIYw1MgVSp
0CELBHyW6QJWOl4JDVwkgZarNNaJUZ5nKchlvhlELElEcgTpQpT0ZUKYgeCQ
xjCkk7TNrz8zBqW6bBmsM1TTsGKaLQXqJsC0gEiEKWGxIDVS7WojSVkqA1rM
ffdNeKz7/q1d/+9M6qtaoriPEbQyfgq7wUKumtVGhR4AOnUWpEAia5d3Jb3q
1cY3FCxJLNBKWYxFaXK0KbK2v46VFeQkSV4LrfEz/0fSKsanBhJeYnLw9QKM
eedYZUufNEWaYpRwC9mCTlXIqwptoMazXHYt91F+OioEOEpcCvT51qMaLdfX
As7xfFy4fEoJRI2L2Sv/9O1wNvOHF6Px2XbhWTYvy88uXpVU/Nn51Bu+G09+
JeUbc9qHHXaNw//lrzk1xg5FkCRJnnZfKL6KMZJJzWQW7jk6yZZzoe2RZQi1
nxCjbghA+UpEKaMGwjnm4vpBnCa49SNo74IWqGqoHmRaC5WWKE80pVMbe+Ty
C9QCcwDi40qj6FXtjTed+N50CjsBUypOAQGzFSYffuEDYgky5xf+l9qxdEWy
PugTHckcMC9ySzHjwrrsG5QHKJVPURt5GT1aMED18kix5BJBrJI1sMUwuIRk
PtBP26IOD0yL6vd6zee2QxW+5v6E8ovgfl7X1jmbYmsQCjioBCwR8PvFePoG
iTecjIbTkT+enHvT18NTb3AfGWOgONP8Xrco4Zt4loANry2ty9iNu9iPNaNN
eKhwEbIsSo2Ht8TgJWJIdc0iye1RIf26Ejkj7IpzTEsGqvDC8SYfqGT5d92B
i6ffQoun34GLH38HriHdQ+gcDvqHg25v6x3Y6feJX/Q6MPT6GaMtVZHO07N3
789m43MPSdu7u2l72OvxB2/ke5PR+zNMeGXvrtR9qlX61cYWpLusqezj/Wuy
ibLFDbSlZrbX0dGDqkvJ5W0/RPKF8SNbBPRUkhjLydNYUsg+hSaF7I/kyUOY
BwP3YCtR+j3TiOjVs0zBvgk32NCoYdOUVMHp5HyBc4zNih1oTOvfGfJrpmi2
GWl5LfQOLGMuIA7NrseljiO4GDp9Gl6KZxfGdp8VykYpwUErWACzl8qcBVcF
TqZkSlbjMGzSwgYWocOCJTAegfvF7T/vtvHldjo4xXHSKpodBPFyFUmGjb+m
YnuWpN7cAKN5Dq3Q9BWr6Ct09p052n5/+u7OARQMy84bt6wrn2UUQZylK4Sa
dff83lsPEoaWRQK19HO8gRMs8OYTUVIvjq1pFpWKywA/ODphVkMd03VlAoT9
UwURFoS63IAiucP9q9/+ya0ZqJZJHt3GNKOMvD/Gp17NRqkJJkwuRaDS4iZ9
tmZeQi1TibxU6EAUq8s6PIPaIxdbfrO3rrG+Yu0rnF8RY8cbjadnb+3l3cIR
mWOp3m5SqPItGeKch2t5w5j8uW4UVsC0/Zd3+5bd4yxlNFQ96uDHT7mLdoYq
2ezkk/Cmja1Ny0reNLfidH8QjtOxu/R7YwcYkvyGNflAArsHdRo9/ncC4ZEE
/gu0zdPcUA4AAA==
---1463811839-1487233806-1055445218=:9849--


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
