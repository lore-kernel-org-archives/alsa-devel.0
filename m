From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB audio devices on Audio 4DJ and similar
Date: Wed, 11 Apr 2012 17:20:17 +0200
Message-ID: <4F85A131.7000508@gmail.com>
References: <201204062209.21564.gineera@aspect135.co.uk>
	<4F819CBD.2010809@gmail.com>
	<201204111159.18537.gineera@aspect135.co.uk>
	<4F85A083.2020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E57691043B0
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 17:20:20 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so836519bkw.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2012 08:20:20 -0700 (PDT)
In-Reply-To: <4F85A083.2020302@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11.04.2012 17:17, Daniel Mack wrote:
> Erm. Class compliant USB cards speak _LE formats only, and I'm not aware
> of any hardware that is able to switch endianess on a run-time
> configuration base. Does that mean PortAudio is unable to feed these
> cards on BE hosts like PowerPC? Does the sound output endianess always
> have to match the audio stream format?

That should of course read: "Does the host endianess always
have to match the audio stream format?"
