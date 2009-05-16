From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Another successful X-Fi driver test.
Date: Sat, 16 May 2009 15:56:23 -0400
Message-ID: <604760770905161256v46379ffak23e00ff8d420931b@mail.gmail.com>
References: <8de04f330905161225p519fa8bek5d718c469538b5c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BCDA243B7
	for <Alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 21:56:24 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so1864348yxn.2
	for <Alsa-devel@alsa-project.org>; Sat, 16 May 2009 12:56:23 -0700 (PDT)
In-Reply-To: <8de04f330905161225p519fa8bek5d718c469538b5c4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "A.Haq Abbad" <haqman@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The driver snapshot installs only alsa-driver. You shouldn't encounter any
problems in 9.04 wrt kernel- userspace sync.

On May 16, 2009 3:26 PM, "A.Haq Abbad" <haqman@gmail.com> wrote:

Here are some details:

System:
Intel Core 2 Duo E6600
Asus P5W DH Motherboard
X-Fi eXtreme Music
Intel HD audio onboard

Software:
Advanced Linux Sound Architecture Driver Version 1.0.20.
Compiled on May 16 2009 for kernel 2.6.28-11-generic (SMP).

Running Kubuntu 9.04, with default packages.

All major audio players tested and work fine.
Aduiocious does not work with 24bit mode as reported before.

System is stable, no issues encountered yet!

Recording through the mic works flawlessly.
Sound from speakers seem clear.
Switching between intel HD onboard audio and xfi
works fine, both enabled on the same system.

P.S
I installed the file alsa-driver-unstable-snapshot.tar.gz
now my alsa version is 1.0.20 instead of .18, does that
cause major issues? I thought the package will only install the
module snd-ctxfi, not the whole alsa! or is that not possible.

Let me know if you want me to run specific test.

Regards.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
