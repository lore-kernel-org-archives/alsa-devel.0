From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: emu10k1 multichannel support & 2.6.11.rc4 - bug?
Date: Thu, 17 Feb 2005 11:42:26 +1100
Message-ID: <4213E872.8060502@machinehasnoagenda.com>
References: <1108514291.3772.19.camel@krustophenia.net>	 <42129C4F.4060507@machinehasnoagenda.com>	 <1108515965.14789.1.camel@krustophenia.net>	 <4212D49F.40404@machinehasnoagenda.com>	 <1108530906.26851.2.camel@krustophenia.net>	 <4212F6EF.1040306@machinehasnoagenda.com>	 <421347C7.9080506@machinehasnoagenda.com>	 <1108574835.28955.2.camel@krustophenia.net>	 <4213DA03.8000100@machinehasnoagenda.com>	 <1108597041.3481.1.camel@krustophenia.net> <1108597405.3481.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108597405.3481.4.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Wed, 2005-02-16 at 18:37 -0500, Lee Revell wrote:
>  
>
>>On Thu, 2005-02-17 at 10:40 +1100, Shayne O'Connor wrote:
>>    
>>
>>>it must have been something to do with this, cos i just booted into the
>>>newer kernel (2.6.11.rc4), started jack, and got 16 inputs :)
>>>
>>>      
>>>
>>Great!  I am testing ALSA CVS now, hopefully it's synced up.
>>    
>>
>
>OK, looks like the patches are in.  I get the hw:0,3 device with ALSA
>CVS.  The pm_message_t bug is also fixed, so it should just work.
>
>  
>
looks good to me! i'm assuming the capture and playback patches are now
included in cvs, cos compilation and installation gave me 16 ins and
outs ... if this is correct, everything is good, and i've successfully
compiled/installed alsa cvs for the first time!

shayne


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
