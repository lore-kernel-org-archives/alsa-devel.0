From: suresh gupta <sureshgupta189@gmail.com>
Subject: Re: LSI HDA Modem is not working on HP new Laptop
 which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver
 1.0.24.
Date: Thu, 29 Sep 2011 12:48:56 +0530
Message-ID: <CAJTbaX2F9HY0m1JkDSA=0bYYMLqP9K=K8xHk3cjQttSK0fWqLg@mail.gmail.com>
References: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
	<s5hipobc1it.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id CC09D243A7
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 09:19:17 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so330443bkb.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 00:19:16 -0700 (PDT)
In-Reply-To: <s5hipobc1it.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Gupta, Suresh" <Suresh.Gupta@lsi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

LSI Modem always checks the =93opened=94 bit of =93azx_dev=94 before openin=
g the
stream. Modem sets =93opened=94 bit and use stream if and only if that =93o=
pened=94
bit was not set otherwise move to next stream =93azx_dev=94.



I found that the ALSA unset this "opened" bit on close but do not
reset  AC_VERB_SET_CHANNEL_STREAMID
of IDC codec.

Due to which IDC Codec always get active and always sending data to stream
0. Now when LSI modem check the "opened"

bit of stream 0, it found it is not set and open the stream 0 and start
reading data from stream 0. As IDC codec still sending data on stream 0 the
LSI Modem get this unexpected data and stop working.



I believe the Code (below) which checks "no_sticky_stream" is the culprit
due to which "really_cleanup_stream"

function is not called. I found the Analog devices codec set
"no_sticky_stream" while probing their codec.

This is the reason, our modem works on HP laptop with Analog device codec.



According to me the IDC codec should stop sending data after closing the
stream or otherwise they should always acquire the stream which is not
right.



I don=92t know why "no_sticky_stream" come into new code and what=92s it
significance. Why only Analog devices use this "no_sticky_stream".



Thanks

SuresH



void __snd_hda_codec_cleanup_stream(struct hda_codec *codec, hda_nid_t nid,

                            int do_now)

{

      struct hda_cvt_setup *p;

      if (!nid)

            return;



      if (codec->no_sticky_stream)

            do_now =3D 1;



      snd_printdd("hda_codec_cleanup_stream: NID=3D0x%x\n", nid);

      p =3D get_hda_cvt_setup(codec, nid);

      if (p) {

            /* here we just clear the active flag when do_now isn't set;

             * actual clean-ups will be done later in

             * purify_inactive_streams() called from snd_hda_codec_prpapre()

             */

            if (do_now)

                  really_cleanup_stream(codec, p);

            else

                  p->active =3D 0;

      }

}


On Thu, Sep 29, 2011 at 11:50 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 29 Sep 2011 10:51:28 +0530,
> Gupta, Suresh wrote:
> >
> > Modem receive unwanted data on stream 0 even stream is not open by any
> device.
> > Stream 0 was acquired by IDC 7605 and this codec keep sending something
> even after closing the stream.
>
> Why does the LSI modem device receive from the stream of IDT codec at
> all?  In other words, how does LSI modem driver manage the allocation
> of streams?
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
