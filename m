From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Fri, 3 Jul 2015 23:03:05 +0200
Message-ID: <CALUcmUmR3XCaQFjEbPtsPYS6QcRdkWFdtry+x3uWP7qLE07ePg@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
 <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
 <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
 <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC52265099
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 23:03:26 +0200 (CEST)
Received: by obbop1 with SMTP id op1so75333781obb.2
 for <alsa-devel@alsa-project.org>; Fri, 03 Jul 2015 14:03:25 -0700 (PDT)
In-Reply-To: <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The jack test gives

Without external speaker plugged in:

Pin 0x12 (Internal Mic): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black Headphone, Left side): present = No
Pin 0x16 (Not connected): present = No
Pin 0x18 (Not connected): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Not connected): present = No
Pin 0x1f (Not connected): present = No

With external speaker plugged in:

Pin 0x12 (Internal Mic): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black Headphone, Left side): present = No
Pin 0x16 (Not connected): present = No
Pin 0x18 (Not connected): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = Yes
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Not connected): present = No
Pin 0x1f (Not connected): present = No

For the other parts, I lack the experience.
I have just set up a test environment, so I can recompile and test kernels
without breaking my main system.

If you have any patches to suggest and test (for the external speaker and
the auto switch of headset), I am all ears.
If not, I will try to dig in it myself.

On 3 July 2015 at 04:20, Raymond Yau <superquad.vortex2@gmail.com> wrote:

>
> >
> > "hdajacksensetest -a" gives
> >
> > Pin 0x05 ( Digital Out, HDMI): present = No
> > Pin 0x06 ( Digital Out, HDMI): present = No
> > Pin 0x07 (Not connected): present = No
> >
> > which is a bit of a surprise to me, since at least the headphones (of
> the headset I plugin) has working jack detection. I would expect to see at
> least to have 1 non-HDMI pin connected.
>
> You need to specify card number
>
> hdajacksensetest -c1 -a
>
> If the external subwoofer can be detected with other unconnected pin
> complex instead of node 0x1a jack sense, you need to call
> snd_hda_jack_add_kctl in your fixup
>
> snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
>   const char *name)
>
> >
> > ----
> >
> > > Can user giveup some combo jack capability (remove the support of
> headphone and mic jack and only support headset ) by early patching to
> reenable auto mic selection ?
> >
> > To this I don't know the answer.
> >
> > An image of the side with the different jacks:
> >
> http://www.notebookcheck.net/fileadmin/Notebooks/Asus/N751JK-T4144H/rechts.jpg
> >
> > The yellow is the external speaker
> > The one next to the USB ports is the headset with a logo of a headset
> and a microphone drawn in it.
>
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=73bdd597823e2231dc882577dbbaf8df92fe1775
>
> [ALC668_FIXUP_DELL_MIC_NO_PRESENCE] = {
> + .type = HDA_FIXUP_PINS,
> + .v.pins = (const struct hda_pintbl[]) {
> + { 0x19, 0x03a1913d }, /* use as headphone mic, without its own jack
> detect */
> + { 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack detect
> */
> + { }
> + },
> + .chained = true,
> + .chain_id = ALC668_FIXUP_HEADSET_MODE
> + },
> + [ALC668_FIXUP_HEADSET_MODE] = {
> + .type = HDA_FIXUP_FUNC,
> + .v.func = alc_fixup_headset_mode_alc668,
> + },
>
> No need to change if you are using headphone since default is headphone
>
> Support of Headphone mic can be removed by
> alc_fixup_headset_mode_no_hp_mic()
>
> You need to hack the driver to set current_headset_type to cita or omtp
> instead of unknown
>
> spec->current_headset_type = ALC_HEADSET_MODE_UNKNOWN;
>
>


-- 
Arthur Borsboom
Lieven de Keystraat 77
3067 KG, Rotterdam
The Netherlands
Mob: +31629089953
Email: arthurborsboom@gmail.com
Skype: Arthur Borsboom, The Hague, The Netherlands

[image: View Arthur's LinkedIn profile]
<http://uk.linkedin.com/in/arthurborsboom>
