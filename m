From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: usx2y jack driver
Date: Sun, 26 Sep 2004 14:48:13 +0100 (WEST)
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <33090.192.168.1.5.1096206493.squirrel@192.168.1.5>
References: <200409222228.38243.annabellesgarden@yahoo.de>
    <32827.192.168.1.5.1096065064.squirrel@192.168.1.5>
    <1096078552.1407.1.camel@krustophenia.net>
    <200409251555.59384.annabellesgarden@yahoo.de>
    <32983.192.168.1.5.1096125029.squirrel@192.168.1.5>
    <1096157614.3697.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096157614.3697.26.camel@krustophenia.net>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> Rui Nuno Capela wrote:
>>
>> FYI, on my laptop, that OHCI issue is still a serious showstopper. I am
>> collecting some log/trace data to file and append on alsa's bugtracker
>> (bug #0000425).
>
> One other idea.  Do you have CONFIG_DEBUG_SPINLOCK_SLEEP enabled?  If
> this problem is indeed related to the sleeping in PCM start/stop
> callbacks, and you enable this option, then I believe you would get a
> "Bad: scheduling while atomic" error in the syslog before the machine
> hangs.
>

Yes I have CONFIG_DEBUG_SPINLOCK_SLEEP enabled and nothing shows up on the
logs, at least as you say. I have already conducted my tests with
netconsole as you and Ingo suggested, and posted some early results on
alsa's bugtracker.

Hope to light up some bulb on Karsten's head ;)

Thank.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
