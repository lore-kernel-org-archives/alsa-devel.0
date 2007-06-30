From: "j t" <mark473@gmail.com>
Subject: High-pitched noise on output from cmi9739
	(snd_intel8x0)
Date: Sat, 30 Jun 2007 11:57:43 +0100
Message-ID: <b88f52540706300357h486a70deke6e1a4553c65225b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D27F245D8
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2007 12:57:45 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so239849ana
	for <alsa-devel@alsa-project.org>; Sat, 30 Jun 2007 03:57:43 -0700 (PDT)
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

Hi all.

I have a cmi9739 (sis7012) built into an asus k7s8x motherboard which
produces a quiet but noticeable noise on top of the regular output
(the noise only occurs during playback).

I logged a bug to alsa's bugtrack:
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2288) about a
year ago, but unfortunately I still have the problem with alsa release
1.0.14

To try to find out what's going on, I tried using seven (7) different
drivers for this soundcard (both Linux and Windows XP) to find out
when the problem occurs. Here's the results:

a) Alsa (snd_intel8x0) version 1.0.14 under Ubuntu 7.10 alpha 2. Problem EXISTS.

b) OSS 4Front Opensound v4.1 (v4.1test0-070624). Problem EXISTS

c) CMedia Linux OSS driver cmaudio-070 (from
http://www.cmedia.com.tw). Problem EXISTS.

d) Windows XP "built-in" driver for SiS 7012 version 5.10.0.6120.
Problem EXISTS.

e) Windows XP drivers from Asus website for SiS 7012 version
5.12.1.38. Problem DOES NOT EXIST.

f) Windows XP drivers from CMedia website (http://www.cmedia.com.tw)
version 5.12.1.39. Problem DOES NOT EXIST.

g) Windows XP drivers from CMedia forum
(http://www.cmedia.com.tw/forums) version
5.12.1.51. Problem DOES NOT EXIST.

Given that the problem does not happen with three out of the seven
drivers, I assume it's a driver problem. Is there anything that I can
do debug this further?

Thank you.
