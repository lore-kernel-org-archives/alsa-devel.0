From: Al Steffens <apsteffe@netwood.net>
Subject: proposed change to amidi: allow data from stdin
Date: Sat, 09 Oct 2010 17:04:45 -0700
Message-ID: <4CB1031D.2050503@netwood.net>
Reply-To: apsteffe@netwood.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao103.cox.net (fed1rmmtao103.cox.net [68.230.241.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 069452413F
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 02:06:16 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao103.cox.net
	(InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP id
	<20101010000616.VOPV23084.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Sat, 9 Oct 2010 20:06:16 -0400
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

ALSA Developers,

Proposed change to amidi:  allow data from stdin.

A simple addition to amidi to allow midi commands from standard input 
would facilitate a MIDI-over-IP setup in which amidi and netcat together 
could send/receive raw MIDI over a network, or the internet.  I'm 
thinking of something as simple as

nc host port | amidi -p hw:1,0

to receive raw midi from someone on the internet and pipe the midi 
commands to one of my tone generators.  This would further the effort to 
realize the "online jamming" idea with MIDI.

Currently, amidi will read raw MIDI commands from a file using the "-s" 
flag.  I have tried this with a named pipe, but amidi tries to get the 
file size causing an error.  Perhaps fixing this would be one solution.

Al Steffens
apsteffe@netwood.net
