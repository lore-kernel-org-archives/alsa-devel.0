From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Query regarding ALSA control interface
Date: Tue, 24 Jul 2007 04:46:11 +0530
Message-ID: <61445c750707231616s1936fda3p4fa0677cc187860c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B27E103829
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 01:16:13 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2363816wag
	for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2007 16:16:11 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
I am writing a pcm control interface for my alsa driver. I am confused about
how the switches are used.
I have implemented simple cases like following and they are working well.

static int audio_path_info(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_info *uinfo)
{
       /*Count is 256 since the values can vary from 0-255. But values fall
in this range only*/

        uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
        uinfo->count = 256;
        uinfo->value.integer.min = 0;
        uinfo->value.integer.max = 255;
        FN_EXIT;
        return 0;
}
static int audio_path_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
    my_mixer_t *mixer_chip = snd_kcontrol_chip(kcontrol);
    ucontrol->value.integer.value[0] = mixer_chip->echo;
    ucontrol->value.integer.value[1] = mixer_chip->echo;
    return 0;
}
static int audio_path_put(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
        my_mixer_t *mixer_chip = snd_kcontrol_chip(kcontrol);
       -----
       ----
}


Now, I have to implement a control which takes four different values..namely
0,1.100 and 101. In this case what shoud be the type of control? It should
be ENUMERATED or INTEGER? I am confused here since the values are not
exactly in a range.

-pharaoh.
