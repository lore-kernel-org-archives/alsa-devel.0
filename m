From: stan <gryt2@q.com>
Subject: Re: how to configure .asoundrc to make arecord use a
 default device
Date: Wed, 29 Jul 2009 10:51:27 -0700
Message-ID: <BLU0-SMTP42E68ED59128B653919DDEEE120@phx.gbl>
References: <4A7044BE.5040509@powercraft.nl>
	<BLU0-SMTP84CC10D8E05E93F48EBC3DEE120@phx.gbl>
	<4A708386.2070501@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s8.blu0.hotmail.com (blu0-omc3-s8.blu0.hotmail.com
	[65.55.116.83]) by alsa0.perex.cz (Postfix) with ESMTP id 12D341038BE
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 19:50:07 +0200 (CEST)
In-Reply-To: <4A708386.2070501@powercraft.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Jul 2009 19:14:46 +0200
Jelle de Jong <jelledejong@powercraft.nl> wrote:


> 
> Hi Stan thanks for helping out.
<snip>
> I am no asourdrc specialist and I always have got issues

Neither am I!  Ditto with the issues.  There are experts around.

> understanding the syntax when it comes down to more complicated
> setups. I know I need to make the audiodevice0 the default device.
> But how can I do this without losing my mixing support, how I
> configure it so it has dmix and dsnoop as default devices?
> 
> An example how to fix my asoundrc would be really helpful.

You're asking the wrong guy!  I just use the page I pointed you to, web
search, and trial and error to get an .asoundrc that works.  I don't
actually use one right now.

I notice that your USB device is actually interpreted as 4 cards.  Are
they each of different functionality?  You could try (as a wild guess):

> pcm.!default {
>     type plug{
>        slave.pcm dmixer
         slave.pcm drecord
      }
> }
> pcm.dmixer {
>     type dmix
>     ipc_key 1024
>     slave.pcm hw:audiodevice0
> }
 pcm.drecord {
     type dsnoop
     ipc_key 1025
     slave.pcm hw:audiodevice0
 }
> ctl.!default {
>      type hw
>      card audiodevice0
> }
> ctl.dmixer {
>     type hw
>     card audiodevice0
> }
> ctl.drecord {
>     type hw
>     card audiodevice0
> }
> pcm.dsp {
>      type plug {
>        slave.pcm dmixer
>        slave.pcm drecord
       }
> }
> ctl.mixer {
>      type hw
>      card audiodevice0
> }

All this is supposition on my part.  Maybe it will give you enough of a
hint in some way to get it working.
