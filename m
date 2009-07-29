From: stan <gryt2@q.com>
Subject: Re: how to configure .asoundrc to make arecord use a
 default device
Date: Wed, 29 Jul 2009 08:28:40 -0700
Message-ID: <BLU0-SMTP84CC10D8E05E93F48EBC3DEE120@phx.gbl>
References: <4A7044BE.5040509@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s24.blu0.hotmail.com (blu0-omc3-s24.blu0.hotmail.com
	[65.55.116.99]) by alsa0.perex.cz (Postfix) with ESMTP id 4799F103849
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 17:27:20 +0200 (CEST)
In-Reply-To: <4A7044BE.5040509@powercraft.nl>
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

On Wed, 29 Jul 2009 14:46:54 +0200
Jelle de Jong <jelledejong@powercraft.nl> wrote:

> Hello everybody,
> 
> I am having some issues making arecord use the default device for 
> recording. Could somebody help me get a working .asoundrc
> configuration?

> It works with:
> arecord -v -f S16_LE -r 44100 -D audiodevice0 ~/record0.wav
> but it does not work with:
> arecord -v -f S16_LE -r 44100 ~/record0.wav

Make audiodevice0 your default device

http://www.alsa-project.org/main/index.php/Asoundrc#The_default_plugin
