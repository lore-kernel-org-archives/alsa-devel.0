From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: surround51 problems. (problem patch identified)
Date: Mon, 10 Oct 2005 20:41:42 +0100
Message-ID: <434AC3F6.1010109@superbug.co.uk>
References: <E1EBEWw-0006Qa-Li@sc8-pr-cvs1.sourceforge.net>	<4348105C.2050809@superbug.co.uk>	<43481297.6080504@superbug.co.uk>	<s5hfyr9aca8.wl%tiwai@suse.de>	<434A4C65.5000004@superbug.co.uk>	<s5hd5mdaald.wl%tiwai@suse.de> <s5hu0fpxup4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0fpxup4.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>>
>>>The tests I did were:
>>>
>>>speaker-test -c6 -Dsurround51
>>>speaker-test -c6 -Dplug:surround51
>>>
>>>Both failed as far as I can remember (I will double check tonight)
>>>I was using a standard Audigy2 config, with no .asoundrc.
>>
>>OK, then it's very likely a problem of multi layer.
> 
> 
> A wrong guess: It was a lower one, hook plugin.
> 
> Now fixed on CVS.  The upcoming 1.0.10rc2 should be OK.
> 
> 
> Takashi
> 
> 

I have just tested, and I can confirm that is is fixed.

Thank you

James


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
