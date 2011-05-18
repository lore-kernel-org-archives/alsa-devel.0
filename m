From: Daniel Mack <zonque@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
	Ultra (8R)
Date: Wed, 18 May 2011 19:51:29 +0200
Message-ID: <BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A5609103821
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 19:51:33 +0200 (CEST)
Received: by pvf33 with SMTP id 33so982935pvf.38
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 10:51:29 -0700 (PDT)
In-Reply-To: <4DD3E39D.30100@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

HI Felix,

On Wed, May 18, 2011 at 5:19 PM, Felix Homann <linuxaudio@showlabor.de> wrote:
> I need some help again by someone who's more familiar with Alsa's inner
> working than I am. This might be you, Daniel ;-)
>
> I've attached a patch series that would add support for the mixer in
> M-Audio's Fast Track Ultra (8R) devices.
>
> BUT, it will break others!
>
> It will break others in that mixer controls will show up multiple times. The
> reason for this seems to be my ambitiuos calling of snd_usb_create_mixer()
> for quirked devices in card.c. To circumvent the problem of a control
> showing up multiple times, I check for duplicates in
> add_unique_control_to_empty_mixer() and skip controls already present.

Hmm, I'm not sure whether I understand what you're trying to do. You
want to add mixers that are not added by the generic driver? Then just
have a look how this is done for other devices, like for example for
the "Traktor Audio 10". Or do I miss your point?


As a general rule, let the check-patch.pl script that ships with the
kernel have a look at your patches, it will point out obvious coding
style issues and the like :)


Daniel
