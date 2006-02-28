From: Rimas Kudelis <rq@akl.lt>
Subject: Re: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Tue, 28 Feb 2006 15:55:05 +0200
Message-ID: <44045639.8090502@akl.lt>
References: <200602280125.k1S1Pmlb021588@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602280125.k1S1Pmlb021588@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The patches are in anonymous CVS already. That's great! :)
> There is now a single ADC NID list which can be used by any model which
> utilises the "dual ADC" functionality.  The fujitsu model was the only
> model using this up to this point; now the newly added acer model does
> as well.
>   
Now another question - is there a reason to list ADC's in reversed order
for HP model? If there's none, I think HP model could simply use the
same list that Fujitsu and Acer now use.


>>>> * If the jack is called "Line In", should I leave it as "Line" in 
>>>> mixer, or should I name it "Line In"?
>>>>         
>>> What do you think is less confusing?
>>>       
>> I don't actually know. It doesn't make significant difference for me, 
>> so it's hard to tell. I'm just asking about the policy - is "Line" a 
>> conventional name in ALSA, or is it a convention to name controls like 
>> jacks?..
>>     
> I've left it as "Line" since in this context it's more consistent with the
> rest of ALSA.
>   
That's great. Takashi has provided us with a good reason to leave it as is.

> Feel free to grab the 7 patches and give them a whirl. Note that they
> are against a recent CVS version of alsa.  Hopefully though it won't be
> too long before they show up in CVS.
As I said, I can already see the changes in
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/hda/. I think
I'll try them out today. Hopefully, I'll find out whether the CD and
Beep controls actually do anything on Acers at all.

Best regards,
Rimas



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
