From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Docking stations
Date: Wed, 25 Feb 2009 01:05:03 -0500
Message-ID: <75b66ecd0902242205m41010c36m355680c348660bea@mail.gmail.com>
References: <20090225022508.GA32681@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 40AB424393
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 07:05:04 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so1234126qwf.56
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 22:05:03 -0800 (PST)
In-Reply-To: <20090225022508.GA32681@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 24, 2009 at 9:25 PM, Lennart Poettering <mznyfn@0pointer.de> wrote:
> there's now some support to be notified about docking station events
> in the kernel. It probably would make a lot of sense if PulseAudio
> would listen for these and reprogram the alsa control stuff to switch
> over to the audio jacks of the docking station and back.
>
> I am wondering if there is any defined scheme for doing this
> switching? i.e. is there an established name for a mixer element that
> needs to be switched for this?

Good luck, it looks ugly:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/258630

;-)

Lee
