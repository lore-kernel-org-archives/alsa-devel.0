From: Paul Davis <pbd@op.net>
Subject: Re: ALSA docs
Date: Mon, 29 Jul 2002 14:12:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17ZEzS-0001Sf-00@usw-sf-list1.sourceforge.net>
References: <3D4581A8.80808@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 30 Jul 2002 02:55:52 +0900."
             <3D4581A8.80808@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Do you mean that I should be parsing each driver file seperately?

not really, just do a single pass over each one of them at some point
in time. store the results, and use them. this should get you started
(its not perfect, but it doesn't do a bad job.

#!/usr/local/bin/perl

while(<>) {
	  if (/MODULE_PARM_DESC/) {
	      @foo = split /[()]/;
              @bar = split (/,/, $foo[1], 2);
	      $bar[1] =~ s/"//g;
              printf ("%-32s %s\n", $bar[0], $bar[1]);
          }
}

add something to recurse through the source tree, and include the
module name and card name info, and you're pretty much done ...

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
