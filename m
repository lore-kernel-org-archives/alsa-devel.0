From: bruce <bruce_mcc48@yahoo.ca>
Subject: usb audio
Date: Fri, 07 Aug 2009 00:00:14 -0700
Message-ID: <4A7BD0FE.405@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp147.mail.mud.yahoo.com (smtp147.mail.mud.yahoo.com
	[209.191.106.58]) by alsa0.perex.cz (Postfix) with SMTP id A91BF2438A
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 09:00:15 +0200 (CEST)
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

Hi I have the TASCAM US-122L USB.I am using ubuntu studio 9.04.The usb 
audio inputs and outputs are no functional cant fined them anywhere I am 
using jack connection kit on my studio the midi are recognized but not 
the audio.I have submitted to launchpad this report.Here are my jack 
start up log
this is with tascam us-122L set as input and output.It will start with 
just tascam input but there is no audio only midi with that start.

jackd 0.116.1

Copyright 2001-2005 Paul Davis and others.

jackd comes with ABSOLUTELY NO WARRANTY

This is free software, and you are welcome to redistribute it

under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.

server `default' registered

23:53:21.206 JACK was started with PID=8295.

registered builtin port type 32 bit float mono audio

registered builtin port type 8 bit raw midi

clock source = system clock via clock_gettime

start poll on 3 fd's

loading driver ..

new client: alsa_pcm, id = 1 type 1 @ 0x9821d48 fd = -1

apparent rate = 44100

creating alsa driver ... hw:1|hw:1|1024|3|44100|0|0|hwmon|hwmeter|-|32bit

control device hw:1

23:53:21.383 ALSA active patchbay scan...

23:53:21.407 jack-imput-output003: 14:0 Midi Through -> 20:0 TASCAM 
US-122L checked.

23:53:21.416 ALSA connection change.

23:53:21.811 ALSA active patchbay scan...

23:53:21.813 jack-imput-output003: 14:0 Midi Through -> 20:0 TASCAM 
US-122L checked.

ALSA: Cannot open PCM device alsa_pcm for playback. Falling back to 
capture-only mode

cannot load driver module alsa

starting server engine shutdown

server thread back from poll

freeing shared port segments

stopping server thread

last xrun delay: 0.000 usecs

max delay reported by backend: 0.000 usecs

freeing engine shared memory

max usecs: 0.000, engine deleted

cleaning up shared memory

cleaning up files

unregistering server `default'

23:53:22.586 JACK was stopped successfully.

23:53:22.588 Post-shutdown script...

23:53:22.590 killall jackd

jackd: no process killed

23:53:23.015 Post-shutdown script terminated with exit status=256.

23:53:23.727 Could not connect to JACK server as client. - Overall 
operation failed. - Unable to connect to server. Please check the 
messages window for more info.


thank you for any help you mite give :-)   Bruce McCandless
