From: "D. Sen" <dsen@homemail.com>
Subject: Re: intel8x0: changing characteristics after an APM
 suspend-resume cycle
Date: Wed, 08 Jan 2003 08:46:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E1C2BAB.2020006@homemail.com>
References: <3E1B3B2A.4070204@homemail.com> <s5h7kdfalxd.wl@alsa2.suse.de>
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



Takashi Iwai wrote:
> At Tue, 07 Jan 2003 15:40:10 -0500,
> D. Sen <dsen@homemail.com> wrote:
> 
>>Hi,
>>
>>I am using the snd-intel8x0 drivers (0.9.0rc6) on my IBM Thinkpad 
>>running Linux 2.4.20. Everything seems to run fine until the machine 
>>goes through a suspend/resume cycle when mono files/streams seem to get 
>>played back at a much faster rate.
>>
>>A cold reboot resolves the problem.
> 
> 
> even after unloading/reloading the module the problem persists?
> 
> 
> Takashi
> 
> 

I just tried unloading/reloading the modules (had to close mixer 
applications, etc first). But you are right. The problem does NOT 
persist if I unload and then reload the modules.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
