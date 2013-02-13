From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC]Connection list of hda widget
Date: Wed, 13 Feb 2013 11:16:15 +0800
Message-ID: <CAN8ccibsGJZ53juGDG07XuUNc5p8LehdkpYxirmrizbpyenQvg@mail.gmail.com>
References: <CAN8cciaMRg55oO3iMJqngcFqeW==POKiv=+_NraPQ-WzEm4gFQ@mail.gmail.com>
 <CAN8cciYwRrsNPqQhe4zbBYmBpNNEEgQPkosT8dYd4dBFXdHxGA@mail.gmail.com>
 <CAN8cciaaPLvJZH2vP0tVD6d9gppaFRcUgNcytkdac+6HoCc7sg@mail.gmail.com>
 <CAN8ccibiu+_n3rB+Er-8DE-RR7Wy2PHr5Q+gQVE3Ojfny6wtqw@mail.gmail.com>
 <CAN8cciYcdYum7tZMf2wBqk4vVjzKEWNYxQDmaRmo8+Hatk--xQ@mail.gmail.com>
 <5113C3AF.8020709@canonical.com> <s5h4nhoc9vk.wl%tiwai@suse.de>
 <CAN8cciYYeWtTmJ6+UnBW2wcO_0yqgEY=cugEMdnjZaDZjzgtcg@mail.gmail.com>
 <s5hd2wb8fo8.wl%tiwai@suse.de>
 <CAN8cciYXLRWe9dS6DT8uGF8+m=h=gBtgY998s6QGh8TLDfOcww@mail.gmail.com>
 <s5hy5ezb1n6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B732650E7
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 04:16:17 +0100 (CET)
Received: by mail-ie0-f175.google.com with SMTP id c12so1108671ieb.6
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 19:16:16 -0800 (PST)
In-Reply-To: <s5hy5ezb1n6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, Miro Hodak <mhodak127@gmail.com>, basinilya@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> > > > > > >
> > > > > > > ADI codecs  have vendor defined widgets ( BIAS Power-Down and
VREF
> > > > > > > Power-Down) which have connection list
> >
> > >
> > > > Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
> > > >     Connection: 6
> > > > 0x11* 0x12 0x14 0x15 0x16 0x17
> > > >
> > > > My proposed patch just remove "*" from the connection list since
there
> > is
> > > > no way to know the vendor defined widget support the verb
> > GET_CONNECT_SELECT
> > >
> > > You should have written _this_ text at the first place!
> > > The biggest problem is that your description doesn't match with what
> > > you write in your patch.
> > >
> > > But still, it's still an open question.  In the specification, the use
> > > of selector isn't prohibited for vendor-spec widgets.  So, some crazy
> > > h/w designer may think of it.
> > >
> >
> > Yes, it depend on how you interept "Other"
> >
> > 7.3.3.2 Connection Select Control
> > Applies to:
> > Input Converter
> > Selector Widget
> > Pin Complex
> > Other
>
> Heh, and obviously h/w manufacturers thought vendor-spec widget
> belongs to "Other".

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=5fdaecdb0d8fd8131d2adb9ca0ae2b77707b36ca

do you have the connection list in node 0x12 of ad1986a ?


If you prefer the patch to blacklist specific widgets similar to power
widget

Refer to Table 13.Connection List of AD1882 dartasheet

23 A2209811 BC30AE24 NID 11 1 18 20 1 22 24 1 2E 30 1 3C
2F 00171514 NID 14 15 17

Refer to Table 13.Connection List of AD1988 dartasheet

23 25249811 2120BD38 Length 8 NID 11 1 18  24  25  38 1 3D  20  21
2F 15141211 00001716 Length 6  NID 11  12  14  15  16  17

Blacklist ADI codec's vendor defined widgets ( BIAS Power-Down and VREF
Power-Down) which have connection list for not sending
AC_VERB_GET_CONNECT_SEL

static void print_conn_list(struct snd_info_buffer *buffer,
    struct hda_codec *codec, hda_nid_t nid,
    unsigned int wid_type, hda_nid_t *conn,
    int conn_len)
{
int c, curr = -1;

if (conn_len > 1 &&
    wid_type != AC_WID_AUD_MIX &&
    wid_type != AC_WID_VOL_KNB &&
+     (wide_type != AC_WID _VENDOR && ((codec->vendor_id >> 16) != 0x11d4))
&&
    wid_type != AC_WID_POWER)
curr = snd_hda_codec_read(codec, nid, 0,
  AC_VERB_GET_CONNECT_SEL, 0);
snd_iprintf(buffer, "  Connection: %d\n", conn_len);
