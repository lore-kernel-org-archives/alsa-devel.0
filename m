From: Ed Wildgoose <lists@wildgooses.com>
Subject: Problem with RME 9632 and Plug
Date: Tue, 03 Aug 2004 14:46:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410F972E.9080100@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have had a long standing issue with mplayer not working with my RME 
9632.  I have at last finally tracked down part of the problem...

It seems that the RME 9632 in conjunction with the plug device will only 
accept a value of 2 fragments/periods when using the 
"snd_pcm_hw_params_set_periods" call (and the 
"snd_pcm_hw_params_set_periods_near" call sets 2 fragments no matter 
what you ask for).  ....In my case this is causing problems for mplayer 
because this gives too small a buffer, but that's a moot point really...

Can someone please help me debug this further - I'm using Alsa as in the 
2.6.7-mm3 kernel (1.0.5?), but the situation has been like this for a 
while so I don't think exact version numbers are the problem.

Other useful info is that I have written other apps using RtAudio, which 
accesses the hardware layer directly, and although I don't think I 
double checked that I was getting what I asked for, I think I was using 
huge buffers up to 8 or 16 periods.  The point being that direct access 
looks OK, and so this might point to an interaction between Plug and the 
9632 driver?

On the otherhand, mplayer doesn't work for me via the OSS emulation 
either, but the code there doesn't even try to change the frag size, it 
only accepts the default (which is again this small 2 frag buffer).

Any ideas on where to probe next.  I don't really know my way around the 
alsa sources.

Thanks for any help

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
