From: Mark Salazar <markTheCoder@justmyself.net>
Subject: Re: [es18xx.c PATCH] #1/4 for Zoom Video - resolve common
 vs chipset specific mixer controls
Date: Mon, 09 Jan 2006 19:58:18 -0500
Message-ID: <43C306AA.4030900@justmyself.net>
References: <43B00FF2.6030007@justmyself.net>	<1135613234.8293.38.camel@mindpipe>	<43B02A0E.20401@justmyself.net>	<s5h8xtyr9oh.wl%tiwai@suse.de>	<43C199C1.1050301@justmyself.net> <s5hwth9ha4b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwth9ha4b.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>
>Well, I think the below is more straightforward.
>Please let me know if it works, then I'll merge your patches to CVS.
>  
>
Haven't tried yet, but it looks like it should work. If we go this way 
it'll break my 4th patch though where I add the controls for Zoom Video 
so I'll have to rework that as well. I expect the modified version would 
look something like:
- adding a "Video Playback Switch" switch control to snd_es18xx_opt_1869;
- adding a "snd_es18xx_opt_1878" to hold a single volume control "Video 
Playback Volume";
- adding a "snd_es18xx_opt_1879" to hold stereo volume "Video Playback 
Volume",  "Video Playback Volume", and the "Video Playback Switch" controls.
along with the necessary instantiation logic in snd_es18xx_mixer. The 
reason I used one array to hold all the chipset specific control 
information was because I saw the same registers used for different 
controls in different chipsets and I was trying to keep things simple 
and readable (and obvious swtich and single instantiation loop) in 
snd_es18xx_mixer. However this is my first time working ALSA code, and I 
will defer to your opinion.
Which way do you want to go?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
