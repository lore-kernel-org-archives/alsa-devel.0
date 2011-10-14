From: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>
Subject: TWL4030 low-latency
Date: Fri, 14 Oct 2011 11:24:29 -0700
Message-ID: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-roam.stanford.edu (smtp-roam2.Stanford.EDU [171.67.219.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 8619724407
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 20:24:36 +0200 (CEST)
Received: from smtp-roam.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id AAD8778411
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 11:24:32 -0700 (PDT)
Received: from [10.0.0.11] (75-101-95-205.dyn.dsl.coastside.net
	[75.101.95.205]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested) (Authenticated sender: eberdahl)
	by smtp-roam.stanford.edu (Postfix) with ESMTPSA id 1C79B783ED
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 11:24:31 -0700 (PDT)
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

Dear Alsa Devel List,

I would like to send some feedback on the TWL4030 driver when used on the Beagle Board. We have tested it under Ubuntu and Angstrom, and we find it does not work well at low latencies (e.g. input-to-output in 5ms, 10ms, or 20ms). Perhaps it was never tested extensively at these latencies. I thought I would send you this information in case you would look into it, or at least pass it on to the relevant contact. I can also run further tests if someone informs me what I should try.

1) To get the drivers to run at particularly low latencies (e.g. 20ms), it is necessary to operate the drivers in NON-realtime mode. It would interest me to know whether this means that the realtime functionality of the Beagle Board xM hardware or OS is hampered, or whether the TWL4030 driver is not operating up to specification. (If instead the TWL4030 driver is operating in realtime mode, then Jack stops running when an unrelated low-latency USB-serial device is opened.)

2) Some audio software (e.g. Pure Data, ChucK, etc.) will not connect to the TWL4030 ALSA drivers directly, instead they will only start when jack intermediates between the audio software and the TWL4030 ALSA drivers.

3) In some situations, the TWL4030 drivers appear not to start using the requested settings. For example, when we start jack requesting two periods per buffer, it is apparently getting initialized at eight periods per buffer, see the final lines below:
Calling
$ jackd -r -dalsa -dhw:0 -p128 -n2 -i2 -o2 -s -S -r 
on the Beagle under Ubuntu 10.10 and Angstrom demo image results in the following

jackd 0.118.0                                                                   
Copyright 2001-2009 Paul Davis, Stephane Letz, Jack O'Quinn, Torben Hohn and ot.
jackd comes with ABSOLUTELY NO WARRANTY                                         
This is free software, and you are welcome to redistribute it                   
under certain conditions; see the file COPYING for details                      
                                                                                
JACK compiled with System V SHM support.                                        
loading driver ..                                                               
apparent rate = 44100                                                           
creating alsa driver ... hw:0|hw:0|128|2|44100|2|2|nomon|swmeter|soft-mode|16bit
control device hw:0                                                             
configuring for 44100Hz, period = 128 frames (2.9 ms), buffer = 2 periods       
ALSA: final selected sample format for capture: 16bit little-endian             
ALSA: use **8** periods for capture                                                 
ALSA: final selected sample format for playback: 16bit little-endian            
ALSA: use **8** periods for playback                

Thanks very much for listening!

Best,
Edgar Berdahl

Lecturer
Center for Computer Research in Music and Acoustics (CCRMA)
Stanford University
http://ccrma.stanford.edu/courses/250a
