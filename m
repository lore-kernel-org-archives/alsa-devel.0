From: <ico-rDkNP/OoUoU@public.gmane.org>
Subject: snd-hdsp oddities
Date: Fri, 2 Jul 2004 0:22:08 +0000
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040702002208.KXUI17933.smtp2.fuse.net@smtp.fuse.net>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ico-rDkNP/OoUoU@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I am using the latest 2.6.7 kernel (tried also 2.6.5) but with hdsp I cannot select anything lower than 1024x2 buffer settings in jackd without having massive xruns.

Asoundrc is fine, modprobe.conf is fine too.

The hdsp runs fine with the aforementioned settings but anything lower simply is horrible.

The kernel is patched with all kinds of mm patches but I am not currently using -r option nor the realtime module (a bit scared of freezing my machine :-). Is this the best one can do in user-space?

Any help is greatly appreciated!

Best wishes,

Ico
