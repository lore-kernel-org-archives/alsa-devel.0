From: bfowler@ewitness.co.uk (ewitness - Ben Fowler)
Subject: Re: no sound on a G4 powerbook
Date: Thu, 8 Aug 2002 21:30:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <f04330102b9788034507e@[192.168.254.56]>
References: <E17csg0-0006xY-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17csg0-0006xY-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Date: Thu, 08 Aug 2002 17:59:11 +0200
>From: Takashi Iwai <tiwai@suse.de>
>Subject: [Alsa-devel] Re: no sound on a G4 powerbook
>
>Hi,
>
>At Thu, 8 Aug 2002 17:42:34 +0200,
>Maarten de Boer wrote:
>>
>> Hello,
>>
> > I am trying to get alsa working on a G4 powerbook (Tumbler).
> > I am using the  latest CVS sources, but have also tried rc2.
> > Modules load, I unmute and adjust volume, but alas: no sound.
> >
>> The dmasound_pmac modules however do work and sound.
>> But obviously, I want alsa.
>>
>> I saw a similar message in the achives:
>> http://www.geocrawler.com/archives/3/12350/2002/3/0/8248990/
>> without reply...
>>
>> Help is greatly appreciated!
>
>i'll start debugging from tomorrow.  please be patient for a while :)
>
>
>ciao,
>
>Takashi

Is this happening with the CD player?

It is possible that Alsa is set-up for CD Audio to reach
the sound hardware on an analogue line. If the sound
hardware, such  as 'Screamer' does not have such an
input then it may be impossible to raise the CD volume
above zero (check the maximum level quoted in amixer).

Modern Macs do not use analogue connections between the
CD player and the sound hardware, but a digital connection.

There is a patch to xmms that may help.
<URL: http://www.imaclinux.net/gh.php?single=18 >

Ben.
-- 
Privileged/Confidential Information may be contained in this message.
If you are not the addressee indicated in this message (or responsible 
for delivery of the message to such person), you may not copy or deliver 
this message to anyone. In such case, you should destroy this message 
and kindly notify the sender by reply email.  Please advise immediately 
if you or your employer do not consent to Internet email messages of this
kind.  Opinions, conclusions and other information in this message that 
do not relate to the official business of ewitness Limited shall be 
understood as neither given nor endorsed by it.

eWitness Limited, Alpha House, Redvers Close, Lawnswood Business Park, Leeds, LS16 6QY
Telephone:  0113 2951112  Fax: 0113 2951114


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
