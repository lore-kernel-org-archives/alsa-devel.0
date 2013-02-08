From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC]Connection list of hda widget
Date: Fri, 8 Feb 2013 16:37:51 +0800
Message-ID: <CAN8cciYXLRWe9dS6DT8uGF8+m=h=gBtgY998s6QGh8TLDfOcww@mail.gmail.com>
References: <CAN8cciaMRg55oO3iMJqngcFqeW==POKiv=+_NraPQ-WzEm4gFQ@mail.gmail.com>
 <CAN8cciYwRrsNPqQhe4zbBYmBpNNEEgQPkosT8dYd4dBFXdHxGA@mail.gmail.com>
 <CAN8cciaaPLvJZH2vP0tVD6d9gppaFRcUgNcytkdac+6HoCc7sg@mail.gmail.com>
 <CAN8ccibiu+_n3rB+Er-8DE-RR7Wy2PHr5Q+gQVE3Ojfny6wtqw@mail.gmail.com>
 <CAN8cciYcdYum7tZMf2wBqk4vVjzKEWNYxQDmaRmo8+Hatk--xQ@mail.gmail.com>
 <5113C3AF.8020709@canonical.com> <s5h4nhoc9vk.wl%tiwai@suse.de>
 <CAN8cciYYeWtTmJ6+UnBW2wcO_0yqgEY=cugEMdnjZaDZjzgtcg@mail.gmail.com>
 <s5hd2wb8fo8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id C468526532C
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 09:37:52 +0100 (CET)
Received: by mail-ie0-f172.google.com with SMTP id c10so4788847ieb.3
 for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2013 00:37:51 -0800 (PST)
In-Reply-To: <s5hd2wb8fo8.wl%tiwai@suse.de>
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

> >
> > > > >
> > > > > Treat vendor defined widget different from audio selector/audio
input
> > > > > widget since hda_proc.c query the connection list of vendor
defined
> > widget
> > > > >
> > > > > ADI codecs  have vendor defined widgets ( BIAS Power-Down and VREF
> > > > > Power-Down) which have connection list
> > > > >
> > > > > static void print_conn_list(struct snd_info_buffer *buffer,
> > > > >      struct hda_codec *codec, hda_nid_t nid,
> > > > >      unsigned int wid_type, hda_nid_t *conn,
> > > > >      int conn_len)
> > > > > {
> > > > > int c, curr = -1;
> > > > >
> > > > > if (conn_len > 1 &&
> > > > >      wid_type != AC_WID_AUD_MIX &&
> > > > >      wid_type != AC_WID_VOL_KNB &&
> > > > > +     wide_type != AC_WID_VENDOR &&
> > > > >      wid_type != AC_WID_POWER)
> > > > > curr = snd_hda_codec_read(codec, nid, 0,
> > > > >    AC_VERB_GET_CONNECT_SEL, 0);
> > > > > snd_iprintf(buffer, "  Connection: %d\n", conn_len);
> > > > >

>
> > Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
> >     Connection: 6
> > 0x11* 0x12 0x14 0x15 0x16 0x17
> >
> > My proposed patch just remove "*" from the connection list since there
is
> > no way to know the vendor defined widget support the verb
GET_CONNECT_SELECT
>
> You should have written _this_ text at the first place!
> The biggest problem is that your description doesn't match with what
> you write in your patch.
>
> But still, it's still an open question.  In the specification, the use
> of selector isn't prohibited for vendor-spec widgets.  So, some crazy
> h/w designer may think of it.
>

Yes, it depend on how you interept "Other"

7.3.3.2 Connection Select Control
Applies to:
Input Converter
Selector Widget
Pin Complex
Other

I think your patch is not necessary, what is missing are the codec
responses when error occur on ad1882

-static const char * const ad1882_models[AD1986A_MODELS] = {
+static const char * const ad1882_models[AD19882_MODELS] = {
         [AD1882_AUTO]           = "auto",
         [AD1882_3STACK]         = "3stack",
         [AD1882_6STACK]         = "6stack",
         [AD1882_3STACK_AUTOMUTE] = "3stack-automute",
};

>
