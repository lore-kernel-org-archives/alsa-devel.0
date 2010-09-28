From: Josh Lehan <alsa@krellan.com>
Subject: MIDI utility amidicat and alsa-utils
Date: Mon, 27 Sep 2010 22:57:47 -0700
Message-ID: <4CA183DB.2070500@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server4.hostdango.com (server4.hostdango.com [70.86.37.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D006103881
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 07:57:51 +0200 (CEST)
Received: from adsl-71-133-204-142.dsl.pltn13.pacbell.net ([71.133.204.142]
	helo=[10.6.9.2])
	by server4.hostdango.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <alsa@krellan.com>) id 1P0TC7-0004zB-Qb
	for alsa-devel@alsa-project.org; Mon, 27 Sep 2010 22:57:39 -0700
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

Hello.  Back at the start of this year, I was looking for a way to send
arbitrary data into or out of the ALSA MIDI subsystem from the command
line.  Upon failing to find a solution, I wrote a little utility program
to do just that, called "amidicat":

http://krellan.com/amidicat/

When the idea was first talked about, Takashi Iwai mentioned that it
might be useful to have in alsa-utils.

I'm wondering if this is still the case?  If so, what would be necessary
to adapt my program to fit in and become a well-behaved member of
alsa-utils?  Does it need to compile on other platforms besides Linux,
be internationalized, etc.?

Josh
