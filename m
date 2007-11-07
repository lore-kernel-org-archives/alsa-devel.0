From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Mr. Takashi Iwai Help-me please
Date: Tue, 6 Nov 2007 22:12:10 -0200
Message-ID: <5f52f6d70711061612q3f3b252fjb999e4106ad60193@mail.gmail.com>
References: <002701c8209f$8994d320$6700a8c0@sisprof.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 38AA724341
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 01:12:13 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1471999rvb
	for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2007 16:12:11 -0800 (PST)
In-Reply-To: <002701c8209f$8994d320$6700a8c0@sisprof.com.br>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eduardo <pinedu@uol.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/6/07, Eduardo <pinedu@uol.com.br> wrote:

> This is a Philips Microsystem with a USB port
> This USB periferic need a special boot sequence, i debug this sequence in the linux kernel and the default boot for "usbaudio.c" don't solve the problem.

If this is a reasonably regular USB Audio device, it could be a matter
of adding a quirk handler to the driver. However, from what Philips
says, it does much more than standard audio streaming with things like
remote control and mp3 uploading. I have a synth that switches from
USB storage to MIDI using a button in the panel, but I don't know if
you system does something similar.
