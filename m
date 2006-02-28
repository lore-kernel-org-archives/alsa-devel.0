From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and
 similar laptops
Date: Tue, 28 Feb 2006 16:32:47 +0200
Message-ID: <44045F0F.20507@akl.lt>
References: <200602280125.k1S1Pmlb021588@auster.physics.adelaide.edu.au>	<44045639.8090502@akl.lt> <s5hhd6jr27t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhd6jr27t.wl%tiwai@suse.de>
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

>>> There is now a single ADC NID list which can be used by any model which
>>> utilises the "dual ADC" functionality.  The fujitsu model was the only
>>> model using this up to this point; now the newly added acer model does
>>> as well.
>>>       
>> Now another question - is there a reason to list ADC's in reversed order
>> for HP model? If there's none, I think HP model could simply use the
>> same list that Fujitsu and Acer now use.
>>     
> It's just a historical reason.  The original realtek driver did it so,
> and I didn't want a possible breakage.  Once after we confirm that it
> works regardless of the order, we can reuse the same list. 
>
> Can anyone test it?

Would it be enough to test things vice-versa (e.g. swapping them for
acer or test model on an Acer)? ;)

Rimas



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
