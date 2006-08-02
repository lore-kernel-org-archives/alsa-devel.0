From: Julien Bramary <julien.bramary@blueyonder.co.uk>
Subject: Re: Trigger Callback
Date: Wed, 02 Aug 2006 13:16:10 +0100
Message-ID: <44D0978A.10401@blueyonder.co.uk>
References: <44CFB014.2050704@blueyonder.co.uk>	<1154462119.14540.73.camel@mindpipe>	<44CFB620.40609@blueyonder.co.uk>
	<s5hslkf9xzj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hslkf9xzj.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 01 Aug 2006 21:14:24 +0100,
> Julien Bramary wrote:
>   
>> Lee Revell wrote:
>>
>>     
>>>>  > "PCM engine" refers to the hardware's PCM engine, not ALSA's.  It's 100%
>>>>  > device dependent - you need to consult the docs for your sound device to
>>>>  > determine how to start the PCM.
>>>>  >
>>>>  > Lee
>>>>         
>> Thanks, I see now why it starts, I'm doing some inits in my dac in the
>> open callback... I should do those here in the trigger.
>>     
>
> Remember that the trigger callback is designed really as a "trigger".
> That is, it should be executed as shortly as possible.  The callback
> is even in the atomic context within spinlock and irq disablement, so
> any function that my sleep shall cause lockup.
>
> If you need to allocate something, it should be done in either
> open, hw_params or prepare callback.  Only start and stop are done in
> trigger callback.
>
>
> Takashi
>
>   
Thanks for the reminder. I think this should be ok. The only function I 
now have in the trigger is the following 'write' (atomic enough):
   /* enable SSC data Tx */
   at91_ssc_write(AT91_SSC_CR, AT91_SSC_TXEN);

Cheers,
Julien


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
