From: Liam Girdwood <lrg@ti.com>
Subject: Re: [alsa-devel] Query about alsa ucm (use case manager) config files
Date: Wed, 31 Oct 2012 14:26:49 +0000
Message-ID: <50913529.2030906@ti.com>
References: <1351688372.28030.18.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351688372.28030.18.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, arun.raghavan@collabora.co.ukMark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 31/10/12 12:59, Ashish Chavan wrote:
> Hi,
>    I am just curious to know if there is any centralized repository for
> alsa use case manager configuration files. I tried searching and could
> only find alsa-ucm-conf.git repo at alsa project git server, which is
> actually an empty repo!
> 

This is the correct place, but I've been busy with other stuff to push our configs upstream to date (will do so today now). The eventual contents of this repo are intended to be copied into :-

/usr/share/alsa/ucm (or where ever alsa is installed on your distro)

However, I've not had a chance to push the UCM Nexus and Pandaboard files from Arun to this repo yet due to some other ongoing work.

FYI, Arun's current UCM configs are here :-

http://cgit.collabora.com/git/android/platform/external/collabora/pulseaudio-android.git/log/data/alsa/ucm/Tuna/VoiceCall

> How people share/reuse ucm configuration files for a specific codec?
> In near future, I will be developing few ucm configuration files for
> some codecs and wish to share them with rest of the world. I think even
> though ucm configs are board/machine specific, it makes sense to share
> them. Is there any other, more visible place to put these config files
> than board specific distributions?
> 

Interesting idea to create separate shareable codec UCM configuration. We currently have no way to "include" a shareable codec specific configuration into a machine specific configuration but it would probably not be too hard to add to the parser.

Regards

Liam
