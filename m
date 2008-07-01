From: "Mitul Sen (misen)" <misen@cisco.com>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
	let	me apply hardware parameters
Date: Tue, 1 Jul 2008 16:50:36 -0700
Message-ID: <3B6F5C9068D5864096EB291236C3386F02CE1633@xmb-sjc-21d.amer.cisco.com>
References: <486AABC6.6020906@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	by alsa0.perex.cz (Postfix) with ESMTP id BABA1244CE
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 01:50:59 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <486AABC6.6020906@cox.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Stan,

Thanks for all your help! I have some more questions though...

I downloaded the source code for alsa-lib-1.0.15 
Based on the code, if the format is SND_PCM_FORMAT_MU_LAW, I am not sure
why it does a get/put index to SND_PCM_FORMAT_S16 Also, if the stream is
SND_PCM_STREAM_PLAYBACK, then I would think that it should decode the
data. Why does it call snd_pcm_mulaw_decode function if the format is
SND_PCM_FORMAT_MU_LAW and snd_pcm_mulaw_encode otherwise. I have an
Intel HDA soundcard and according to the specs, it should support PCM
ulaw format.

All ALSA documentation and examples I have come across use specific
hw_params (like sample rate of 44100, SND_PCM_FORMAT_S16, 2 channel
interleaved data). According to the documents, hw_params refer to the
stream related info so that's the reason I tried to change it to that of
mu-law (sampling rate of 8000 Hz, SND_PCM_FORMAT_MU_LAW etc). Not sure
if that's the way to do it though. Based on the code it looks like the
hardware just seems to support SND_PCM_FORMAT_S16. Any pointers to help
me better understand the ALSA code would be much appreciated.

The code that I am referring to is in pcm_mulaw.c and is as follows:-

static int snd_pcm_mulaw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *
params)
{
        snd_pcm_mulaw_t *mulaw = pcm->private_data;
        snd_pcm_format_t format;
        int err = snd_pcm_hw_params_slave(pcm, params,
 
snd_pcm_mulaw_hw_refine_cchange,
 
snd_pcm_mulaw_hw_refine_sprepare,
 
snd_pcm_mulaw_hw_refine_schange,
                                          snd_pcm_generic_hw_params);
        if (err < 0)
                return err;

        err = INTERNAL(snd_pcm_hw_params_get_format)(params, &format);
        if (err < 0)
                return err;

        if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
                if (mulaw->sformat == SND_PCM_FORMAT_MU_LAW) {
                        mulaw->getput_idx =
snd_pcm_linear_get_index(format, SND_PCM_FORMAT_S16);
                        mulaw->func = snd_pcm_mulaw_encode;
                } else {
                        mulaw->getput_idx =
snd_pcm_linear_put_index(SND_PCM_FORMAT_S16, mulaw->sformat);
                        mulaw->func = snd_pcm_mulaw_decode;
                }
        } else {
                if (mulaw->sformat == SND_PCM_FORMAT_MU_LAW) {
                        mulaw->getput_idx =
snd_pcm_linear_put_index(SND_PCM_FORMAT_S16, format);
                        mulaw->func = snd_pcm_mulaw_decode;
                } else {
                        mulaw->getput_idx =
snd_pcm_linear_get_index(mulaw->sformat, SND_PCM_FORMAT_S16);
                        mulaw->func = snd_pcm_mulaw_encode;
                }
        }
        return 0;
}  

Thanks and regards,
Mitul

-----Original Message-----
From: stan [mailto:ghjeold_i_mwee@cox.net] 
Sent: Tuesday, July 01, 2008 3:12 PM
To: Mitul Sen (misen)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Setting format to SND_PCM_FORMAT_MU_LAW does
not let me apply hardware parameters

Mitul Sen (misen) wrote:
>
> Thanks for your suggestions. For the first suggestion, how would I 
> know the version of alsa-lib that I am using so that I can download 
> the source code for the same? Is alsa-lib the same as libasound? Under

> /usr/lib/libasound.so I have a symbolic link to libasound.so.2.0.0. Is

> that then the version I should be looking for?
>
> I am really new to this so please excuse me if these questions are too

> basic for this forum!
>
> Thanks,
> Mitul
>
Good queston.  I know because of the package.  You can find the driver 
version by running    cat  /proc/asound/version    and the utilities 
version by running   aplay --version   .
I couldn't find a way to get the library version.  You can use the run 
   alsa-info.sh --no-upload     and the output will have the driver, 
library, and tool version at the top.
The script is found at http://www.alsa-project.org/alsa-info.sh

libasound is always version 2.0.0, no matter the alsa-lib version.  I
presume that is to facilitate testing and upgrading.  Nothing will break
with newer versions.  So that is unrelated to alsa version.

You can find the latest beta versions of all the alsa source here  

http://www.alsa-project.org/main/index.php/Changes_v1.0.17rc2_v1.0.17rc3

And a link to the latest stable release here http://www.alsa-project.org
