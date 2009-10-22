From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Exemple of source code for capture without using
	callback
Date: Thu, 22 Oct 2009 15:40:05 +0100
Message-ID: <ad2655cb0910220740k5ef0f931j7f0ec48cb5d01cec@mail.gmail.com>
References: <26289049-EACA-4DC6-A396-E2AF4EB6F2E9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ABEE24399
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:40:06 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id d23so2584265fga.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2009 07:40:06 -0700 (PDT)
In-Reply-To: <26289049-EACA-4DC6-A396-E2AF4EB6F2E9@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: brunal2496 gmail <brunal2496@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/10/20 brunal2496 gmail <brunal2496@gmail.com>:
>
> I'm trying to interface a voice recognition software with the alsa
> drivers.
>
> I have to get audio from alsa convert it and then send to the
> recognition engine.
> I've read everywhere that using callback is a bad method to use the
> alsa drivers.
>

This is wrong. callback is the best method.
With current distributions all doing pulseaudio, it would probably be
better interfacing with pulse.
If you need a more professional real time interface, use jackd interface.
For what you need, jackd is probably the simplest api to use.
