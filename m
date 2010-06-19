From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Sat, 19 Jun 2010 08:39:35 +0800
Message-ID: <AANLkTinZFz6NyImuanu7guAg1fiP2hynu55NqeN4apyH@mail.gmail.com>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
	<hv912l$j53$1@dough.gmane.org>
	<AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>
	<hvbgo6$3fg$1@dough.gmane.org>
	<AANLkTinYBKzxiITOnspsn2QOh_Rdv8FHu_PC7K7cGCXm@mail.gmail.com>
	<4C1951F1.4000504@colin.guthr.ie>
	<AANLkTim8q8dbV5-jyeHev1lh1b8HQOzhEETKBSa4o1Ol@mail.gmail.com>
	<AANLkTimjd_PDBv9agMxqCeMr_Kd1lTuwo2TIwLVRp00U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 15279244A1
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 02:39:36 +0200 (CEST)
Received: by vws6 with SMTP id 6so174342vws.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2010 17:39:36 -0700 (PDT)
In-Reply-To: <AANLkTimjd_PDBv9agMxqCeMr_Kd1lTuwo2TIwLVRp00U@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/17 James Courtier-Dutton <james.dutton@gmail.com>

> On 17 June 2010 00:34, Raymond Yau <superquad.vortex2@gmail.com> wrote:
> > 2010/6/17 Colin Guthrie <gmane@colin.guthr.ie>
> >
> >
> >>> But this sucks as
> >>> the percentage shown in alsa is not the same as the percentage shown in
> >>> other GUIs.
> >
> > alsamixer and amixer 's percentage were not designed as your purpose
> >
> > Have you studied the source code of alsamixer and amixer
> >
> > the alsa developers have already posted a lot of time in the mailist list
> ,
> > they prefer to use dB scale instead of percentage
> >
>
> That is exactly why percentages are bad. One cannot relate one control
> to another if one used percentages.
> Say that an  audio card had two controls that adjust the gain of the
> audio one after the other.
> If I set to to 5% above base_volume and the second 5% below
> base_volume, would the output be base_volume???
> the first 5% might be +5dB, and the second might be -4dB, one does not
> know.
>
> Whereas, in dB, if one was set to -5dB, and the other set to +5dB, we
> would be sure that the accumulative output would have a gain of 0dB.
> Percentages are not nor real units at all, dB are.
>
> Kind Regards
>
> James
>

It is because alsamixer and amixer only need to display the "Master" volume
control of one card at a time while pavucontrol and the new version of gnome
volume control have to handle the "Master" volume control when PA switch
sound cards

Different sound cards have different dB rangle for Playback and Capture.

If PA really use decibel range defined in those codec/DAC specification , it
has to resize the slider of the Master Volume control or rescaling the
sliders

To simpify the implementation of the slider ,  a new "PA dB scale" is used
by shift those +12dB(base volume) to 0dB and insist that every sound card 's
minimum_dB is -inf dB ,

This mean that all sound cards will now have same "PA  dB range" , the
volume slider does not need resize or rescaling any more. This is why they
prefer to use percentage to make you believe their calculation of dB is
correct
