From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Silencing plops / click sounds on start / stop of
 playing audio when snd_hda_intel.power_save=1
Date: Fri, 15 Dec 2017 14:49:19 +0100
Message-ID: <ec7801cb-0673-8a5e-e379-d1a441197f65@perex.cz>
References: <522e1590-6f1c-6c7d-4c8a-96c5dcbf6051@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF32267B4F
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 14:49:24 +0100 (CET)
In-Reply-To: <522e1590-6f1c-6c7d-4c8a-96c5dcbf6051@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: jeremy@jcline.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Dne 15.12.2017 v 13:35 Hans de Goede napsal(a):
> Hi All,
> 
> For Fedora 28 we plan to ship the kernel with snd_hda_intel.power_save
> defaulting to 1:
> 
> https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife
> 
> We've had an update for F27 in updates-testing for a while which made
> the same change for F27, but we've received several bug reports
> about plops / click sounds on start / stop of playing audio:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1525104
> 
> I know others have probably already tried fixing this, but I'm
> wondering if there are any ideas how to fix this / things to try?
> 
> Ideas of my own:
> 
> 1) Mute the speakers / headphone output in the mixer before
> activating power-saving. Question how hard would it be to
> make this happen?
> 
> 2) Put a delay between various steps involved in turning
> things off / on.

Hi,

I am a bit skeptic about those proposals. I think that the drivers
should do this job, because some hardware variants have different
requirements for the proper power-off/on sequence.

The problem appears like an improper voltage change and the HDA driver
has already a lot of code which is trying to eliminate these pops (but
as you can see, it is not sufficient).

Honestly, I don't know if it's good to keep this "hidden" to users or
enable the power save feature by default and let users to report this,
so we can look into this problem more when the affected hardware is
identified.

					Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
