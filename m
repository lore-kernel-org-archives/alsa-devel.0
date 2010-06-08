From: Josh Lehan <alsa@krellan.com>
Subject: New release of amidicat program,
	connecting MIDI to stdin/out
Date: Tue, 08 Jun 2010 00:35:04 -0700
Message-ID: <4C0DF2A8.8000305@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server3.hostdango.com (server3.hostdango.com [67.222.146.219])
	by alsa0.perex.cz (Postfix) with ESMTP id B8C2910380A
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 09:35:07 +0200 (CEST)
Received: from c-24-4-183-246.hsd1.ca.comcast.net ([24.4.183.246]
	helo=[10.6.9.2])
	by server3.hostdango.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <alsa@krellan.com>) id 1OLtKy-0007EF-Oi
	for alsa-devel@alsa-project.org; Tue, 08 Jun 2010 00:35:04 -0700
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

Hello.  On the mailing list a few months ago, mentioned a program I had
written, then called "midicat".  Found out there's another product by
that name.  So, the new name of the program is "amidicat".  The "a"
prefix also clarifies that it's an ALSA program.

It's a program that connects the ALSA MIDI sequencer to standard input
and output.  Among other things, this is fun for prototyping quick MIDI
one-liners on the command line, such as "echo 903C7F | amidicat" to play
Middle C.

I have made a new release of the program, which is basically unchanged,
except for a few bug fixes (thanks to Valgrind for discovering a minor
memory leak).  The biggest improvement is that there's now a manual page
and a DocBook documentation page.

Here's the webpage for amidicat, if interested:

http://www.krellan.com/amidicat/

The download is there.  Have fun, and thanks for reading this.

Josh Lehan
