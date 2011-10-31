From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] RFC for snd-usb: rework usb endpoint
	logic
Date: Mon, 31 Oct 2011 13:38:20 +0100
Message-ID: <4EAE96BC.6060605@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B166246BE
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 13:38:32 +0100 (CET)
Received: by eyz10 with SMTP id 10so5079215eyz.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 05:38:31 -0700 (PDT)
In-Reply-To: <1320063030-3502-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/31/2011 01:10 PM, Daniel Mack wrote:
> I didn't sign-off the patches on purpose, as I would really like to
> get them reviewed before they go in. Can people have a look and state
> whether the whole idea is at all sane?

To briefly state the idea as such: the new implementation defines a 
model (snd_usb_endpoint) that handles everything that is related to an 
USB endpoint and its streaming. There are functions to activate and 
deactivate an endpoint (which call usb_set_interface()), and to start 
and stop its URBs. It also has function pointers to be called when data 
was received or is about to be sent, and pointer to a sync slave 
(another snd_usb_endpoint) that is informed when data has been received. 
A snd_usb_endpoint knows about its state and implements a refcounting, 
so only the first user will actually start the URBs and only the last 
one to stop it will tear them down again.

With this sort of abstraction, the actual streaming is decoupled from 
the pcm handling, which makes the "implicit feedback" mechanisms easy to 
implement. All the code that actually handles the payload of a stream's 
packets is now implemented in pcm.c, which is were it belongs to.

But I'm sure there are some unresolved corner cases which need attention.


Daniel
