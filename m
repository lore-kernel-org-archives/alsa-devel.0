From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: configuration space never flattened? Bug?
Date: Mon, 3 May 2004 20:07:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56-Maildir.0405032006340.7680@yme.midgardsormen.net>
References: <Pine.HPX.4.33n.0404301138460.5787-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404301138460.5787-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Apr 2004, Clemens Ladisch wrote:
>Erik Inge Bolsø wrote:
>> I'm having trouble doing snd_pcm_hw_params_can_pause() on a certain pcm,
>> even though it has already (hopefully?) been fixed to one config by
>> snd_pcm_hw_params()... snd_pcm_hw_params has been called, at least. How
>> can I check?
>>
>> fileja {
>>         type file
>>         file /tmp/alsa
>>         slave.pcm null
>> }
>>
>> xine: pcm.c:2604: snd_pcm_hw_params_can_pause: Assertion `params && params->info != ~0U' failed.
>
>Apparently, the null pcm doesn't initialize params->info.
>
>The patch below should help.

Yep, works fine. Thanks!

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
