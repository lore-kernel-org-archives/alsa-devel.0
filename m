From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd_pcm_multi_rewind
Date: Tue, 24 Aug 2010 11:56:56 +0800
Message-ID: <AANLkTinY8Q1d2Bo4HSVQYKAeRy0K_xPHU9Y-bT=m1t9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id BDD46245C7
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 05:56:56 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3043539ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 20:56:56 -0700 (PDT)
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

why the pos array can be assigned dimension by multi->slaves_count ?

does sizeof(pos) return the correct size ?

why input parameter "frames" can be modified ?

        frames = f;



static snd_pcm_sframes_t snd_pcm_multi_rewind(snd_pcm_t *pcm,
snd_pcm_uframes_t frames)
{
    snd_pcm_multi_t *multi = pcm->private_data;
    unsigned int i;
    snd_pcm_uframes_t pos[multi->slaves_count];
    memset(pos, 0, sizeof(pos));
    for (i = 0; i < multi->slaves_count; ++i) {
        snd_pcm_t *slave_i = multi->slaves[i].pcm;
        snd_pcm_sframes_t f = snd_pcm_rewind(slave_i, frames);
        if (f < 0)
            return f;
        pos[i] = f;
        frames = f;
    }
    /* Realign the pointers */
    for (i = 0; i < multi->slaves_count; ++i) {
        snd_pcm_t *slave_i = multi->slaves[i].pcm;
        snd_pcm_uframes_t f = pos[i] - frames;
        snd_pcm_sframes_t result;
        if (f > 0) {
            result = INTERNAL(snd_pcm_forward)(slave_i, f);
            if (result < 0)
                return result;
            if ((snd_pcm_uframes_t)result != f)
                return -EIO;
        }
    }
    return frames;
}
