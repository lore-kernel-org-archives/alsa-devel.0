From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Tue, 9 Dec 2008 14:25:33 +0530
Message-ID: <98769532B4BB14429434178695419EAE268E0FA6@bgsmsx501.gar.corp.intel.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
	<98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
	<493E31E3.2080504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D858B1037FF
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 09:56:22 +0100 (CET)
In-Reply-To: <493E31E3.2080504@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

If I define mixer controls to switch between each substream, I would not be able to handle multiple streams at time.... 
I had asked this in my earlier follow up email as well - can I use snd_pcm_t->private_data to communicate if it's a voice or audio 
I understand this private_data gets copied to substream->private data which will reach the driver...
Am I right here?

-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Tuesday, December 09, 2008 2:23 PM
To: Harsha, Priya
Cc: Lee Revell; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] question on hardware mixing

Harsha, Priya wrote:
> In the trigger function - I see that from substream->runtime->private_data,
> voice specific parameters are extracted. How and can somehow user space
> fill in some private data to the driver so that driver can process voice
> in a different way and music in a different way?

On the Emu10k1 chip, the hardware voices are used for both PCM playback
and wavetable (MIDI) playback.  Voice-specific parameters are set for
MIDI data; the parameters come from the soundfont that was loaded to
specify how the instruments sound.  (Here, the term "voice" has no
relation to the sound of a human voice.)

As far as PCM playback is concerned, ALSA does not have any predefined
mechanism to differentiate between voice and music audio streams.  It
would be possible to define mixer controls to switch between these
settings for each substream.


HTH
Clemens
