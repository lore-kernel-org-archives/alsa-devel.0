From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Query regarding pcm->private_data
Date: Sat, 16 Jun 2007 19:43:27 +0530
Message-ID: <61445c750706160713u3fe57101ic524fe20d4b5eee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D4A410381A
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 16:13:29 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so2139186pyi
	for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2007 07:13:28 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I am reading 'Wring an alsa driver'.  It says following about the
private_data:

You can allocate a record for the substream and store it in
runtime->private_data. Usually, this is done in the open callback.
Don't mix this with pcm->private_data. The pcm->private_data usually
points the chip instance assigned statically at the creation of PCM,
while the
runtime->private_data points a dynamic data created at the PCM open callback.

What does static and dynamic mean here? Apologies for this question
if it sounds very novice, since my understanding is it doesn't mean static
and dynamic in the usual way like stack and heap etc. Why I am being
so paranoid about this has reason:

In my ALSA driver I am assigning pcm->private_data = mychip, but it is
NULL in the snd_pcm_attach_substream() function. I have checked my
code many times and I tried with another driver which was working when
tested using ALSA utils. Currently I am testing using the OSS
emulation i.e. simply cat /dev/audio.
