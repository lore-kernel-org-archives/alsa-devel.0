From: David Henningsson <david.henningsson@canonical.com>
Subject: SNDRV_PCM_INFO_BATCH
Date: Tue, 04 Mar 2014 15:20:08 +0100
Message-ID: <5315E118.7060809@canonical.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

So, PulseAudio removed timer scheduling for drivers with
SNDRV_PCM_INFO_BATCH, and released 5.0. Meanwhile, USB drivers still
have SNDRV_PCM_INFO_BATCH, so this leads to performance regressions for
USB sound cards.

The question remains - what does SNDRV_PCM_INFO_BATCH really mean?

In the documentation, we have this:
"int snd_pcm_hw_params_is_batch (const snd_pcm_hw_params_t *params) 	
Check, if hardware does double buffering for data transfers for given
configuration."

What PulseAudio was looking for was more something like "what accuracy
does the pointer callback give us". When we asked this question at the
latest audio meeting, SNDRV_PCM_INFO_BATCH was given as the answer, i e,
if this flag is set, pointer callback have no more accuracy than period
boundaries. At least that's how I understood it.

So, either the documentation for snd_pcm_hw_params_is_batch is correct,
in which case PulseAudio should revert the tsched patch. Or the answer
given at the audio meeting was correct, in which case we need to fix the
USB driver to stop sending the SNDRV_PCM_INFO_BATCH flag.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
