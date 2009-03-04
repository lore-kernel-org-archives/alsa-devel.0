From: Nicolas.Castagne@imag.fr
Subject: Crash when snd_pcm_open is called from a thread with
	"pulse" as playback
Date: Wed, 4 Mar 2009 08:20:49 -0000 (GMT)
Message-ID: <58718.147.171.149.152.1236154849.squirrel@acroe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imag.imag.fr (imag.imag.fr [129.88.30.1])
	by alsa0.perex.cz (Postfix) with ESMTP id BD8301037F3
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 10:00:45 +0100 (CET)
Received: from acroe.imag.fr (acroe.imag.fr [147.171.149.150])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n248vx0p020041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 4 Mar 2009 09:58:00 +0100 (CET)
Received: from acroe.imag.fr (localhost [127.0.0.1])
	by acroe.imag.fr (8.13.8/8.13.8/ImagV2.1) with ESMTP id n248Knex004353
	for <alsa-devel@alsa-project.org>; Wed, 4 Mar 2009 09:20:49 +0100
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

Hi folks,

I hope I post on the correct mail list...
I've read somewhere that I should report bugs on a list, and not only on
the Tracker. That's the aim of this message.


On all my Fedora 10 machines,
whenever
       snd_pcm_open
has been called from a pthread using "pulse" as playback
then the program crashes when the thread terminates.

Crash in __nptl_deallocate_tsd

However, AFAIK, one should be able to call snd_pcm_open from a thread.

The full bug report is there, with a very simple sample code :
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4426

I think this bug relates directly to alsa.
I hope this report is useful.


Best-
Nicolas
