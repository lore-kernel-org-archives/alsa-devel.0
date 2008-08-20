From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: PATCH - vt1618 7.1 Audio
Date: Wed, 20 Aug 2008 12:16:27 -0700
Message-ID: <op.uf685pnb647oa9@jutz-gnto64>
References: <op.uf5sfuct647oa9@jutz-gnto64>
	<s5h1w0knl8o.wl%tiwai@suse.de> <op.uf646zdn647oa9@jutz-gnto64>
	<48AC6AFD.6030806@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E0AA2454C
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 21:37:45 +0200 (CEST)
In-Reply-To: <48AC6AFD.6030806@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 20 Aug 2008 12:05:33 -0700, Rene Herman <rene.herman@keyaccess.nl>  
wrote:

> On 20-08-08 19:50, John L. Utz III wrote:
>
>> On Wed, 20 Aug 2008 01:28:39 -0700, Takashi Iwai <tiwai@suse.de> wrote:
>
>>> Also, a Windows style variable name should be avoided.  People tend to
>>> hate it.
>>  Why would you call this 'Windows Style?' Is that supposed to be a   
>> perjorative comment?
>
> You insult really quickly... :-)

Quickly, but not deeply. :-)

>
> The style is more generally known as Hungarian Notation after its  
> Hungarian "inventor" who was a chief architect at Microsoft.

Yuppers. I know. Charles Simonyi. I really, really, like it.

> This notational conventation saw widespread use in the Windows API and  
> not much use anywhere beyond that.

with an example of 'beyond that' being John Utz's code.

Be it C, Java, C#, Javascript, Ada or any languages that use strong types.

I dont do it in shell script tho:

# Let any boot observers know what devices we found

echo "Type MotherBoard:  ($TYPEMBD)"
echo "Type Soundcard:    ($TYPESND)"
echo "Type Ethenet:      ($TYPEETH)"
echo "Type Modem:        ($TYPEMDM)"


anyway, we can argue about it again after i get a checkpatch compliant  
patch to submit....

johnu

> Rene.
>
