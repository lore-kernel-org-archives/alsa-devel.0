From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: default is working, but hw:0,0 is do not...
Date: Tue, 24 Jan 2012 21:00:16 +0100
Message-ID: <4F1F0DD0.6020101@canonical.com>
References: <BLU0-SMTP104845BEB7A301DD21ED66CC18B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id C96A724602
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 21:00:16 +0100 (CET)
In-Reply-To: <BLU0-SMTP104845BEB7A301DD21ED66CC18B0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitrij K <kdiman@live.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/24/2012 08:15 PM, Dmitrij K wrote:
> Hi all.
>
> I have problem with openning a device for playback.
>
>
> this is working code:
> snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
>
>
> but this is not working:
> snd_pcm_open(&handle, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0);
>
> I get this is: Device or resource busy
>
>
> PS: I have been started the `phonon' (KDE sound daemon), and the amarok (audio
> player).
>
>
> My question: what I need to do for correct open "hw:0,0" for multiply playback
> ?

Make sure that nobody else is using the device at the same time. 
"hw:0,0" requires exclusive access to the device.

You can see who is currently using your sound device(s) using this command:

sudo fuser -v /dev/snd/*

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
