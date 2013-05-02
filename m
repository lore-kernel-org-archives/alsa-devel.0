From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [pulseaudio-discuss] idea: a reserve alsa plugin
Date: Thu, 02 May 2013 18:07:21 +0530
Message-ID: <1367498241.8766.3.camel@localhost>
References: <51824609.30405@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id A9BE526158C
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 14:36:12 +0200 (CEST)
In-Reply-To: <51824609.30405@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-05-02 at 12:55 +0200, David Henningsson wrote:
> Just had an idea which I'll write down here before I forget it 
> again...and I'm not saying I'll implement this anytime soon either, but 
> here goes:
> 
> There is a device reserve protocol between PulseAudio and JACK2 - when 
> JACK needs the sound card, it'll send a dbus message to PulseAudio and 
> grab a name in D-Bus.
> 
> However, there are plenty of applications who like to access ALSA 
> directly, without going through JACK2 or PulseAudio. By making a 
> "reserve" plugin, we could have this functionality for those apps too.
> 
> In practice, if the app usually opens "plughw:0" or "hw:0", it could 
> instead open "reserve:plughw:0" or "reserve:hw:0" to also reserve the 
> device from PulseAudio usage while the device is open. Meanwhile, 
> PulseAudio is free to use other audio devices (which is not the case 
> when using e g pasuspender).
> 
> How does that sound?

Might be neat to do have desktops set up to do this whenever an ALSA
device is opened (that is do it unconditionally when hw:X or plughw:X is
opened).

-- Arun
