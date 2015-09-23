From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2- ALSA 1/3] HDA - Allow hda_jack_tbl to
 use another nid for pin sense
Date: Thu, 24 Sep 2015 00:34:34 +0800
Message-ID: <CAN8cciZ0HKP+RNRRsbNXpo0azmqBKBjejXJRwx8PRuHiw3pZ9w@mail.gmail.com>
References: <CAN8cciYNotgS=1qis4ciOQqoYwjND4y=tpxJGmZt1HGahTV3+Q@mail.gmail.com>
 <s5hvbb16yup.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id E26A1260423
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 18:34:35 +0200 (CEST)
Received: by obbbh8 with SMTP id bh8so37720011obb.0
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 09:34:35 -0700 (PDT)
In-Reply-To: <s5hvbb16yup.wl-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, arthurborsboom@gmail.com
List-Id: alsa-devel@alsa-project.org

> >
> > - add sense_nid to __snd_hda_jack_add_kctl for pin sense
> >
> > - update slave pin sense when master pin sense change
> >
> > - enable unsolicited event when widcap support UNSOL
>
> Again, please describe at first the reason you need this change.  Then
> start explaining about the implementation details.  For example,
> what's the difference from the existing gated_jack.
>
>

I don't understand how gated jack work, but those headset mic in alc668
dell-headset-multi does not  use its own pin sense and won't need to enable
unsol event of the headset mic node.

As pulseaudio don't expect jack kctl can be repesent the state of headphone
and mic

This force the driver to create a headset mic kctl which is just a copy of
the headphone jack kctl
