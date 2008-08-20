From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: PATCH - vt1618 7.1 Audio
Date: Wed, 20 Aug 2008 13:50:45 -0700
Message-ID: <op.uf7divk2647oa9@jutz-gnto64>
References: <op.uf5sfuct647oa9@jutz-gnto64>
	<s5h1w0knl8o.wl%tiwai@suse.de> <op.uf646zdn647oa9@jutz-gnto64>
	<48AC6AFD.6030806@keyaccess.nl> <op.uf685pnb647oa9@jutz-gnto64>
	<48AC766F.1010608@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A80D524579
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 22:52:07 +0200 (CEST)
In-Reply-To: <48AC766F.1010608@keyaccess.nl>
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

On Wed, 20 Aug 2008 12:54:23 -0700, Rene Herman <rene.herman@keyaccess.nl>  
wrote:

> On 20-08-08 21:16, John L. Utz III wrote:
>
>> anyway, we can argue about it again after i get a checkpatch
>> compliant patch to submit....
>
> Let's get a headstart...

hokydokysmoky!

> Note that Hungarian is not a private Takashi Iwai or ALSA dislike; it's  
> rather specifically against the Linux kernel coding style (although the  
> actual CodingStyle document only mentions Hungarian for function names).

'rather specifically' is your interpretation, not a fact.

CodingStyle.C4 just asks that naming be 'Spartan'.

So, to map 'Spartan' to my code:

this is an unsigned short variable that contains a value that will be used  
to shift another variable:

    usigned short usShift;

    ucontrol->value.enumerated.item[0] << usShift;


IMHO, this is a legitimate name in the context of CodingStyle.C4

> Most contributors have had to adjust a few local habits and in the end,  
> it's generally worth it.

right.

'tis why i didnt submit something with a 2 space indent. :-)

`tis why i left my leading 'p's out of the function argument signatures.

> If all is good and well, open source code is read many more times than  
> it's
> written after all and any (significant) style inconsistency costs every  
> reader
> just a little mental hickup.

right. but we differ on what is an inconsistency.

> Review resources are one of the more scarcely available ones in this  
> development process, so a consistent style definitely pays.
>
> Sure, sure, I also try ty get away with things, but Hungarians hickup  
> rather loudly.

I think that folks might be really surprised how helpful hungarian  
notation can be.

But this is a team effort and i am not gonna get all mulish about it  
because it's a very silly thing to be mulish about.

If Takashi tells me that he rejects the next version of the patch solely  
due to the naming of my variables then i will change them.

But if he isnt going to reject it on that basis then they will stay the  
way they are.

It is open source after all. Somebody could submit a patch to change them  
to something they like better.

> Rene.
>
