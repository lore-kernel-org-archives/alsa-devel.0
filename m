From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: Problem using arecord and aplay
Date: Tue, 08 Jan 2008 14:02:54 -0500
Message-ID: <fm0hcu$jtj$1@ger.gmane.org>
References: <e842129b0801080648n5068a377na707b6b5b2a56054@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D1F2433A
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 20:03:06 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JCJj4-0000DD-32
	for alsa-devel@alsa-project.org; Tue, 08 Jan 2008 19:03:02 +0000
Received: from toroon12-1279386361.sdsl.bell.ca ([76.65.226.249])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Jan 2008 19:03:02 +0000
Received: from fmandarino by toroon12-1279386361.sdsl.bell.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Jan 2008 19:03:02 +0000
In-Reply-To: <e842129b0801080648n5068a377na707b6b5b2a56054@mail.gmail.com>
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

conn intel wrote:
> Dear Friends,
> 
> I am using kernel 2.6.22.2, and  following alsa library and utilities :
> alsa-lib-1.0.14a & alsa-utils-1.0.14. I am having problem executing arecord
> and aplay alsa utilities. After executing below command it returns
> immeaditely to command prompt with following messages. The command and
> output::
> 
> # arecord -c 2 -d 10 -f S16_LE -r 44100 -t wav /home/test.wav
> Recording WAVE '/home/test.wav' : Signed 16 bit Little Endian, Rate 44100
> Hz, St
> ereo
> ALSA sound/arm/as352x-audio.c:1153: len:15888
> arecord: set_params:1012: unable to install sw params:
> start_mode: DATA
> xrun_mode: STOP
> tstamp_mode: NONE
> period_step: 1
> sleep_min: 0
> avail_min: 0
> xfer_align: 10
> silence_threshold: 0
> silence_size: 0
> boundary: 1445068800
> #
> 
> waiting for any comments or suggestions.
> 
> Thank you,
> 
> Ankur.

Ankur,

I had the same problem, and used to link aplay statically, until Michel
Benoit determined that building alsa-lib with the configure option
"--with-versioned=no" solved the problem:

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-May/000900.html

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
