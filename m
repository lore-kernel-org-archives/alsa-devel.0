From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio FastTrack C400
Date: Thu, 19 Apr 2012 10:53:59 +0200
Message-ID: <4F8FD2A7.60700@ladisch.de>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9748710B8DC
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 10:50:52 +0200 (CEST)
In-Reply-To: <4F8F7213.8070206@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Chris Cavey wrote:
>  snd-usb-audio: probe of 1-1:1.1 failed with error -5
>  snd-usb-audio: probe of 1-1:1.2 failed with error -5
>  snd-usb-audio: probe of 1-1:1.3 failed with error -5

Are there no other messages immediately before this?

Daniel, are there places where the code aborts without
print an error message?


Regards,
Clemens
