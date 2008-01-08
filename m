From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problem using arecord and aplay
Date: Tue, 08 Jan 2008 17:20:42 +0100
Message-ID: <1199809242.17684.1230116701@webmail.messagingengine.com>
References: <e842129b0801080648n5068a377na707b6b5b2a56054@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 95BD724B37
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 17:20:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e842129b0801080648n5068a377na707b6b5b2a56054@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: conn intel <connintel@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

conn intel wrote:
> # arecord -c 2 -d 10 -f S16_LE -r 44100 -t wav /home/test.wav
> arecord: set_params:1012: unable to install sw params:

Does "amixer contents" output any error message?


Regards,
Clemens
