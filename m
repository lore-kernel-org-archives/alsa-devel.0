From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC]Connection list of hda widget
Date: Fri, 8 Feb 2013 06:33:46 +0800
Message-ID: <CAN8cciYYeWtTmJ6+UnBW2wcO_0yqgEY=cugEMdnjZaDZjzgtcg@mail.gmail.com>
References: <CAN8cciaMRg55oO3iMJqngcFqeW==POKiv=+_NraPQ-WzEm4gFQ@mail.gmail.com>
 <CAN8cciYwRrsNPqQhe4zbBYmBpNNEEgQPkosT8dYd4dBFXdHxGA@mail.gmail.com>
 <CAN8cciaaPLvJZH2vP0tVD6d9gppaFRcUgNcytkdac+6HoCc7sg@mail.gmail.com>
 <CAN8ccibiu+_n3rB+Er-8DE-RR7Wy2PHr5Q+gQVE3Ojfny6wtqw@mail.gmail.com>
 <CAN8cciYcdYum7tZMf2wBqk4vVjzKEWNYxQDmaRmo8+Hatk--xQ@mail.gmail.com>
 <5113C3AF.8020709@canonical.com> <s5h4nhoc9vk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f171.google.com (mail-ia0-f171.google.com
 [209.85.210.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 0942C26530C
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 23:33:47 +0100 (CET)
Received: by mail-ia0-f171.google.com with SMTP id z13so3498830iaz.16
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2013 14:33:46 -0800 (PST)
In-Reply-To: <s5h4nhoc9vk.wl%tiwai@suse.de>
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

> > >
> > > Treat vendor defined widget different from audio selector/audio input
> > > widget since hda_proc.c query the connection list of vendor defined
widget
> > >
> > > ADI codecs  have vendor defined widgets ( BIAS Power-Down and VREF
> > > Power-Down) which have connection list
> > >
> > > static void print_conn_list(struct snd_info_buffer *buffer,
> > >      struct hda_codec *codec, hda_nid_t nid,
> > >      unsigned int wid_type, hda_nid_t *conn,
> > >      int conn_len)
> > > {
> > > int c, curr = -1;
> > >
> > > if (conn_len > 1 &&
> > >      wid_type != AC_WID_AUD_MIX &&
> > >      wid_type != AC_WID_VOL_KNB &&
> > > +     wide_type != AC_WID_VENDOR &&
> > >      wid_type != AC_WID_POWER)
> > > curr = snd_hda_codec_read(codec, nid, 0,
> > >    AC_VERB_GET_CONNECT_SEL, 0);
> > > snd_iprintf(buffer, "  Connection: %d\n", conn_len);
> > >
> >
> > I think there are some Sigmatel/IDT (or was it Analog Devices?) codecs
> > that actually have sensible connections for their vendor specific nodes,
> > so I would prefer not to change this.

Do you mean other codecs  have vendor defined widgets which support
AC_VERB_GET_CONNECT_SEL ?

7.1.2 Node Addressing

Each entry in the connection list is one NID; it may be an independent NID,
indicating a single node, or may be part of a 2-tuple of NIDs delineating a
continuous range of nodes.  The high order bit of each entry indicates how
it is to be interpreted (see Figure 51).  If the range indicator is set,
that list entry forms a range with the previous list entry; i.e., if the
range bit were set on the third list entry, then the second and third
entries form a range, and the first entry is an independent NID.  The range
indicator may not be set in the first entry of a connection list nor may it
be set on any two sequential list entries.  The connection list thus
provides a set of optional inputs to the node.  A connection selector
(control) allows run-time control over which input is used

>
> Right.  The widget connection longer than 32 itself is OK. It's just
> ugly.  That being said, it's basically a bug that we restrict the max
> connection size in the core code.

Node 0x23 [Vendor Defined Widget] wcaps 0xf00100: Mono
   Connection: 18
      0x11* 0x12 0x13 0x14 0x15 0x16 0x17 0x18 0x24 0x25 0x38 0x39 0x3a
0x3b 0x3c 0x3d 0x20 0x21

The length  is 8 and the number of  nodes  in the connection list is 18

Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
    Connection: 6
0x11* 0x12 0x14 0x15 0x16 0x17

My proposed patch just remove "*" from the connection list since there is
no way to know the vendor defined widget support the verb GET_CONNECT_SELECT


Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power: 0x0
    Connection: 2
      0x20* 0x21
