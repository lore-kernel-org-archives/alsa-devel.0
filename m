From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: ALSA driver 1.10.0 and Linux 2.4.32 - a few problems
Date: Mon, 21 Nov 2005 21:33:01 +0000 (GMT)
Message-ID: <20051121213301.53090.qmail@web52914.mail.yahoo.com>
References: <1132600550.29178.78.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1132600550.29178.78.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Lee Revell <rlrevell@joe-job.com> wrote:
> This is not a backtrace.  Run winecfg under gdb and when it segfaults d=
o
> "thread apply all bt".

No it isn't. But wine is more complicated than the average application. w=
inecfg is actually a
shell script that invokes a shared object winecfg.exe.so via the wine exe=
cutable:

$ gdb wine
GNU gdb 6.3
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you =
are
welcome to change it and/or distribute copies of it under certain conditi=
ons.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for detail=
s.
This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db =
library
"/lib/libthread_db.so.1".

(gdb) run winecfg.exe
Starting program: /usr/local/bin/wine winecfg.exe
[Thread debugging using libthread_db enabled]
[New Thread -1209985792 (LWP 12422)]
[New Thread -1209988176 (LWP 12425)]
[Thread -1209988176 (LWP 12425) exited]
Cannot find user-level thread for LWP 12422: generic error
(gdb)=20

Cheers,
Chris



	=09
___________________________________________________________=20
Yahoo! Model Search 2005 - Find the next catwalk superstars - http://uk.n=
ews.yahoo.com/hot/model-search/


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
