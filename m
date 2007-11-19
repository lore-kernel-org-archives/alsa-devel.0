From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Strange bug in .asoundrc ??
Date: Mon, 19 Nov 2007 15:20:05 +0100
Message-ID: <1195482005.19167.1222125449@webmail.messagingengine.com>
References: <47416E4D.3050207@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5261A248AA
	for <Alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 15:20:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47416E4D.3050207@loria.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dominique Larchey-Wendling wrote:
> It seems that neither the current ctl.hw function nor the following
> simplified function ctl.!hw work correctly when the argument CARD is
> given to the function. It works however when no argument is given as the
> following test examples show it.
> 
> Is this a know bug of alsa-lib ? It is strange because this bug does not
>    show up with pcm.hw for example.
> 
> ctl.rha  "hw"
> ctl.tata "hw:0"
> 
> rha % amixer -D rha info
> Card rha 'Intel'/'HDA Intel at 0xfebfc000 irq 16'
> ...
> rha % amixer -D tata info
> ALSA lib control.c:781:(snd_ctl_open_conf) Invalid type for CTL tata definition

Using a string with parameters works only with PCM devices; the code in
alsa-lib that handles other device types doesn't bother to try to look
the string up.

It appears this behaviour is by design.

To get your own definition, write something like this:
  ctl.tata { type hw card 0 }


Regards,
Clemens
