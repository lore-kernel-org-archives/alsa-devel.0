From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Division by zero in snd_pcm_rate_sw_params()
Date: Sat, 24 Jul 2004 11:02:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410233C3.80602@superbug.demon.co.uk>
References: <4101BB9E.8010207@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4101BB9E.8010207@codeweavers.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Francois Gouget <fgouget@codeweavers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Francois Gouget wrote:
> Hi,
> 
> I am working on Wine and lately I have been tracking various sound 
> related issues. One issue I noticed is a crash in Wine's winmm wave test 
> when using the Alsa sound backend.
> 

This and other problems are caused by the many bug/problems with the 
pcm_rate.c plugin. I have been doing some work on the pcm_rate.c plugin, 
and your patch contains something one of the bug fixes I already have 
here fixes. I could reproduce it without needing wine.

Once I have tested my code more fully, I will post a patch to the list.
I have been posting patches for pcm_rate.c already, but although they 
are better than before, they still do not work in all cases.

James


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
