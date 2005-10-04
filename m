From: Mike Hearn <mike@plan99.net>
Subject: Re: Re: Change processname for dmix/dsnoop process
Date: Tue, 04 Oct 2005 19:38:05 +0100
Message-ID: <4342CC0D.30104@plan99.net>
References: <433D491A.8070700@vidsoft.de>	<s5hzmpulit5.wl%tiwai@suse.de>	<pan.2005.10.01.23.13.56.451320@plan99.net>	<s5h3bnheekv.wl%tiwai@suse.de>	<43429444.20903@plan99.net>	<s5hmzlpcozy.wl%tiwai@suse.de> <s5hfyrhch93.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyrhch93.wl%tiwai@suse.de>
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


>It seems not always working.  At least, ps shows the old content while
>pstree shows the new name.  Possibly because /proc entry doesn't
>change.
>

Try changing argv[0] before the exec() call - it's got something to do 
with that. I don't remember exactly.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
