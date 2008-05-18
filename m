From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Forward/rewind APIs return 0
Date: Sun, 18 May 2008 22:38:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02225E755B@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02225E7333@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id B776324354
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 19:08:26 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4IH8JiZ015821
	for <alsa-devel@alsa-project.org>; Sun, 18 May 2008 12:08:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m4IH8IJo016194
	for <alsa-devel@alsa-project.org>; Sun, 18 May 2008 12:08:19 -0500 (CDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02225E7333@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am still waiting for any clues. Please help.

Thanks and Regards,
Anuj Aggarwal

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Aggarwal, Anuj
Sent: Friday, May 16, 2008 4:26 PM
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Forward/rewind APIs return 0

The output from snd_pcm_status_dump () is as below:

Playback Buffer number:2
STRecordAudio: Success for buffer 2, 1078935560
STPlaybackAudio: Success for buffer 2, 1078935560
Before:
  state       : RUNNING
  trigger_time: 4621.974609375
  tstamp      : 4656.881958007
  delay       : 32739
  avail       : 29
  avail_max   : 2048
Playback : Forward No Action
After:
  state       : RUNNING
  trigger_time: 4621.974609375
  tstamp      : 4656.882232666
  delay       : 32726
  avail       : 42
  avail_max   : 42
Playback Buffer number:2
STRecordAudio: Success for buffer 3, 1079988232
STPlaybackAudio: Success for buffer 2, 1078935560
Before:
  state       : RUNNING
  trigger_time: 4621.974609375
  tstamp      : 4668.769989013
  delay       : 32740
  avail       : 28
  avail_max   : 2048
Playback : Forward No Action
After:
  state       : RUNNING
  trigger_time: 4621.974609375
  tstamp      : 4668.770141601
  delay       : 32733
  avail       : 35
  avail_max   : 35
Playback Buffer number:2

I am able to jump but snd_pcm_forward() returns 0. Any sample showing the usage will really help.

Thanks and Regards,
Anuj Aggarwal


-----Original Message-----
From: Jaroslav Kysela [mailto:perex@perex.cz]
Sent: Thursday, May 15, 2008 5:00 PM
To: Aggarwal, Anuj
Cc: alsa-devel@alsa-project.org
Subject: RE: [alsa-devel] Forward/rewind APIs return 0

On Thu, 15 May 2008, Aggarwal, Anuj wrote:

> Please find the output from snd_pcm_dump() attached.

Ok, replace snd_pcm_dump() with snd_pcm_status_dump() and send output
again, please. Also, if you can send me (privately) your test code, I'll
try to check it and reproduce the problem.

                                                Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
