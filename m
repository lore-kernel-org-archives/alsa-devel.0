From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: asihpi: Control naming
Date: Thu, 30 Sep 2010 08:28:22 +0200
Message-ID: <4CA42E06.8000207@canonical.com>
References: <4CA4078E.6010601@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C8E09103917
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 08:28:23 +0200 (CEST)
In-Reply-To: <4CA4078E.6010601@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-09-30 05:44, Eliot Blennerhassett wrote:
> Hi all,
>
> I'm struggling with getting the correct names for controls, so that they
> show up correctly in the Playback or Capture modes of alsamixer
>
> E.g. "PCM 3 Capture Meter" appears in the playback controls?
>
> How is capture vs playback display determined?
> or to put it another way: What are the rules for creating control names.

In addition to Takashi's comment, please consider either making your 
control names compliant with PulseAudio (see earlier post on 
"alsamixertest" for more information), or make a PulseAudio mixer 
profile for your card. (At least until UCM is finished enough.)

Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
