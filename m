From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Intel8x0 problems with rc1
Date: Mon, 01 Dec 2003 20:09:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCB9202.20105@undata.org>
References: <3FCB855F.7080505@undata.org> <s5hd6b8fl1s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6b8fl1s.wl@alsa2.suse.de>
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

Takashi Iwai a écrit :
> At Mon, 01 Dec 2003 19:15:59 +0100,
> Thomas Charbonnel wrote:
> 
>>Hi,
>>
>>I'm testing rc1, and I have problems with my laptop's internal intel8x0
>>soundcard :
>>* Using OSS emulation, after between 19 and 20 seconds of playing the
>>sound gets garbled for a few seconds and then comes back to normal. This
>>happens each time I stop and start playback again.
>>* Using alsa natively there is a performance problem : running jack with 
>>the card (-p 1024) I get 3 or 4 xruns per second (I used to run this 
>>card with -p 64 with previous alsa versions !).
> 
> 
> could you give the specific version which ran properly?
> 

0.9.8 did run ok.

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
