From: "D. Sen" <dsen@homemail.com>
Subject: Re: intel8x0: changing characteristics after an APM
 suspend-resume cycle
Date: Sun, 09 Feb 2003 16:38:31 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E45E957.9000802@homemail.com>
References: <3E1B3B2A.4070204@homemail.com>	<s5h7kdfalxd.wl@alsa2.suse.de>	<3E1C2BAB.2020006@homemail.com> <s5hy95v8ulk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just reporting that the RC7 release did not fix the problem I reported a 
while ago (that the driver doesnt "survive" a suspend/resume cycle on an 
IBM T-30)

Takashi Iwai wrote:
> At Wed, 08 Jan 2003 08:46:19 -0500,
> D. Sen <dsen@homemail.com> wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Tue, 07 Jan 2003 15:40:10 -0500,
>>>D. Sen <dsen@homemail.com> wrote:
>>>
>>>
>>>>Hi,
>>>>
>>>>I am using the snd-intel8x0 drivers (0.9.0rc6) on my IBM Thinkpad 
>>>>running Linux 2.4.20. Everything seems to run fine until the machine 
>>>>goes through a suspend/resume cycle when mono files/streams seem to get 
>>>>played back at a much faster rate.
>>>>
>>>>A cold reboot resolves the problem.
>>>
>>>
>>>even after unloading/reloading the module the problem persists?
>>>
>>>
>>>Takashi
>>>
>>>
>>
>>I just tried unloading/reloading the modules (had to close mixer 
>>applications, etc first). But you are right. The problem does NOT 
>>persist if I unload and then reload the modules.
> 
> 
> hmm, then something lack in the resume procedure.
> i guess the restoration of ac97 registers are not enough.
> will take a look later.
> 
> thanks for your info!
> 
> 
> ciao,
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 

-- 
---------------------------------------
D. Sen, PhD
21 Woodmont Drive
Randolph
NJ 07869
Home Email: dsen@homemail.com   Tel: 973 216 2326
Work Email: dsen@ieee.org       Web: http://www.auditorymodels.org/~dsen



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
