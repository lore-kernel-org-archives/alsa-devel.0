From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: emu10k1 multichannel support & 2.6.11.rc4 - bug?
Date: Thu, 17 Feb 2005 10:40:51 +1100
Message-ID: <4213DA03.8000100@machinehasnoagenda.com>
References: <1108514291.3772.19.camel@krustophenia.net>	 <42129C4F.4060507@machinehasnoagenda.com>	 <1108515965.14789.1.camel@krustophenia.net>	 <4212D49F.40404@machinehasnoagenda.com>	 <1108530906.26851.2.camel@krustophenia.net>	 <4212F6EF.1040306@machinehasnoagenda.com>	 <421347C7.9080506@machinehasnoagenda.com> <1108574835.28955.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108574835.28955.2.camel@krustophenia.net>
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

>On Thu, 2005-02-17 at 00:16 +1100, Shayne O'Connor wrote:
>  
>
>>i've given up on applying the latest patches to cvs, but have
>>encountered a strange problem when trying to apply the 008 version of
>>the patch to the latest Planet CCRMA kernel ...
>>
>>i applied the patch and installed the alsa-driver to the correct module
>>directory (basically performed the same steps as for the previous
>>kernel, except with a cleanly decompressed alsa-driver package) ... but
>>after loading the alsa modules and starting jack, i manage to get 16
>>output channels, but only two input channels ... the hw:0,2 device is
>>there, but qjackctl only lets me specify either "0" or "2" input
>>channels ("0" ends up giving 2 channels) ...
>>    
>>
>
>ALSA CVS changes very fast so I am not surprised you are having
>problems.  Now that all patches are in CVS, try it again in 24 hours and
>let me know if you still have problems.
>
>  
>

>Getting only 2 channels on the hw:0,2 device usually means you loaded
>your old mixer settings after applying the patch.  You can't do that.
>You have to load it with the default mixer settings, then manually
>adjust the mixer.
>  
>
it must have been something to do with this, cos i just booted into the
newer kernel (2.6.11.rc4), started jack, and got 16 inputs :)

btw - congratulations on your invaluable work and thanx for helping out
a somewhat imbecilic tester like me ... is the email you use for these
lists the one to use for paypal? as soon as i've got some moolah to
spare, i'd like to donate a little thankyou.

shayne


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
