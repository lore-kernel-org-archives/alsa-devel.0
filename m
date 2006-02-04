From: Paulo Matias <syscoder@gmail.com>
Subject: Re: ALSA: Pin assignment experiment with ALC260
Date: Sat, 4 Feb 2006 15:06:06 -0200
Message-ID: <acb0c1690602040906p4cb31b50wb1ec117f6197679f@mail.gmail.com>
References: <acb0c1690602011152t458941ffqec82e99bca27aa3c@mail.gmail.com>
	 <200602020022.k120MXhp005529@auster.physics.adelaide.edu.au>
	 <acb0c1690602040905w623d7649l2214bb5fa41736f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <acb0c1690602040905w623d7649l2214bb5fa41736f6@mail.gmail.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry for the delay, I was crowded with work the last days..

> Obviously the first thing I'd do would be to remove the configution of 0x=
15
> and reboot.  Also make completely sure that when you test these changes l=
oad
> the hda with the "model=3Dfujitsu" parameter since it is the fujitsu thin=
gs
> that you are changing (having said this I note that other changes you mad=
e
> to test inputs did have an effect, so I suspect you're already doing this
> bit correctly).

Ok, so I used in /etc/modules.d/alsa:

options snd_hda_intel model=3Dfujitsu

Issued modules-update, then compiled the module with:

static snd_kcontrol_new_t alc260_fujitsu_mixer[] =3D {
        HDA_CODEC_VOLUME("0x08 Volume", 0x08, 0x0, HDA_OUTPUT),
        HDA_BIND_MUTE("0x08 Switch", 0x08, 2, HDA_INPUT),
        HDA_CODEC_VOLUME("0x09 Volume", 0x09, 0x0, HDA_OUTPUT),
        HDA_BIND_MUTE("0x09 Switch", 0x09, 2, HDA_INPUT),
        HDA_CODEC_VOLUME_MONO("0x0A Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
        HDA_BIND_MUTE_MONO("0x0A Switch", 0x0a, 1, 2, HDA_INPUT),
        {
                .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
                .name =3D "Capture Source",
                .info =3D alc_mux_enum_info,
                .get =3D alc_mux_enum_get,
                .put =3D alc_mux_enum_put,
        },
        { } /* end */
};

static struct hda_verb alc260_fujitsu_init_verbs[] =3D {
  {0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x0F, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
  {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
  {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
  {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
};


make && make modules_install

Restarted the computer. No changes: only line and mic jacks working..
the only change is that now I got output from the Mic jack, as I had
set 0x12 to output.

I've found:
Line In Jack - pin 0x14
Mic Jack - pin 0x12

Has I got no other results from that, I have added 0x15 to the list:
  {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},

No effects. I can't imagine what is happening... There is another pin
beyond the pins I've put in the structure? What can be happening?

Thanks,
Paulo Matias


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
