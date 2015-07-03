From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Fri, 3 Jul 2015 10:20:37 +0800
Message-ID: <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
 <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
 <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 34464261A9A
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 04:20:39 +0200 (CEST)
Received: by oiyy130 with SMTP id y130so69251372oiy.0
 for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2015 19:20:38 -0700 (PDT)
In-Reply-To: <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> "hdajacksensetest -a" gives
>
> Pin 0x05 ( Digital Out, HDMI): present = No
> Pin 0x06 ( Digital Out, HDMI): present = No
> Pin 0x07 (Not connected): present = No
>
> which is a bit of a surprise to me, since at least the headphones (of the
headset I plugin) has working jack detection. I would expect to see at
least to have 1 non-HDMI pin connected.

You need to specify card number

hdajacksensetest -c1 -a

If the external subwoofer can be detected with other unconnected pin
complex instead of node 0x1a jack sense, you need to call
snd_hda_jack_add_kctl in your fixup

snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
  const char *name)

>
> ----
>
> > Can user giveup some combo jack capability (remove the support of
headphone and mic jack and only support headset ) by early patching to
reenable auto mic selection ?
>
> To this I don't know the answer.
>
> An image of the side with the different jacks:
>
http://www.notebookcheck.net/fileadmin/Notebooks/Asus/N751JK-T4144H/rechts.jpg
>
> The yellow is the external speaker
> The one next to the USB ports is the headset with a logo of a headset and
a microphone drawn in it.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=73bdd597823e2231dc882577dbbaf8df92fe1775

[ALC668_FIXUP_DELL_MIC_NO_PRESENCE] = {
+ .type = HDA_FIXUP_PINS,
+ .v.pins = (const struct hda_pintbl[]) {
+ { 0x19, 0x03a1913d }, /* use as headphone mic, without its own jack
detect */
+ { 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack detect
*/
+ { }
+ },
+ .chained = true,
+ .chain_id = ALC668_FIXUP_HEADSET_MODE
+ },
+ [ALC668_FIXUP_HEADSET_MODE] = {
+ .type = HDA_FIXUP_FUNC,
+ .v.func = alc_fixup_headset_mode_alc668,
+ },

No need to change if you are using headphone since default is headphone

Support of Headphone mic can be removed by
alc_fixup_headset_mode_no_hp_mic()

You need to hack the driver to set current_headset_type to cita or omtp
instead of unknown

spec->current_headset_type = ALC_HEADSET_MODE_UNKNOWN;
