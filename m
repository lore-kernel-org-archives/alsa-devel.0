From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA-LIB - remove Logitech Web Camera from
	blacklist
Date: Tue, 19 Jun 2012 08:45:20 +0200
Message-ID: <4FE02000.402@canonical.com>
References: <CAN8cciaZ_9ng6XtKBk=0At3Oi42kajS8jjab4egyNW+SZATXmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 128D224515
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 08:45:24 +0200 (CEST)
In-Reply-To: <CAN8cciaZ_9ng6XtKBk=0At3Oi42kajS8jjab4egyNW+SZATXmg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/19/2012 08:29 AM, Raymond Yau wrote:
>   - the commit which add Logitech Web Camera to the
>   blacklist  is redundant since Web Camera does not
>   has any playback device and Pulseaudio does not
>   support digital capture

PulseAudio does support digital capture - the device string 
"iec958:<card>" is tried in both directions.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
